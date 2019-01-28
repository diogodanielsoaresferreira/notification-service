defmodule EmailService.Consumer do
  use GenServer
  use AMQP


  def start_link do
    GenServer.start_link(__MODULE__, [], [])
  end

  @queue "Email"

  def init(_opts) do
    rabbitmq_connect()
  end

  defp rabbitmq_connect do
    case Connection.open([host: System.get_env("BROKER_HOST"), port: 5672]) do
      {:ok, conn} ->
        # Get notifications when the connection goes down
        Process.monitor(conn.pid)
        # Everything else remains the same
        {:ok, chan} = Channel.open(conn)
        {:ok, _consumer_tag} = Basic.consume(chan, @queue)
        {:ok, chan}

      {:error, _} ->
        IO.puts "Reconnecting to RabbitMQ..."
        # Reconnection loop
        :timer.sleep(10000)
        rabbitmq_connect()
    end
  end

  # Confirmation sent by the broker after registering this process as a consumer
  def handle_info({:basic_consume_ok, %{consumer_tag: consumer_tag}}, chan) do
    {:noreply, chan}
  end

  # Sent by the broker when the consumer is unexpectedly cancelled (such as after a queue deletion)
  def handle_info({:basic_cancel, %{consumer_tag: consumer_tag}}, chan) do
    {:stop, :normal, chan}
  end

  # Confirmation sent by the broker to the consumer process after a Basic.cancel
  def handle_info({:basic_cancel_ok, %{consumer_tag: consumer_tag}}, chan) do
    {:noreply, chan}
  end

  # Handle DOWN notifications from the system
  # Should try to reconnect to the server
  def handle_info({:DOWN, _, :process, _pid, _reason}, _) do
    {:ok, chan} = rabbitmq_connect()
    {:noreply, chan}
  end

  def handle_info({:basic_deliver, payload, %{delivery_tag: tag, redelivered: redelivered}}, chan) do
    spawn fn -> consume(chan, tag, redelivered, payload) end
    {:noreply, chan}
  end

  defp consume(channel, tag, redelivered, payload) do
    content = Poison.decode!(payload, as: %EmailService.Message{})
    EmailService.Email.send_notification(content.title, content.message, content.address) 
      |> EmailService.Mailer.deliver_now

    :ok = Basic.ack channel, tag
  rescue
    # Requeue unless it's a redelivered message.
    # This means we will retry consuming a message once in case of exception
    # before we give up and have it moved to the error queue
    #
    # You might also want to catch :exit signal in production code.
    # Make sure you call ack, nack or reject otherwise comsumer will stop
    # receiving messages.
    exception ->
      :ok = Basic.reject channel, tag, requeue: not redelivered
      IO.puts "Error converting #{payload} to message"
  end
end
