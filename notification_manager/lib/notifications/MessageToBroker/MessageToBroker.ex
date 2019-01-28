defmodule Notifications.MessageToBrokerWorker do
  use GenServer
  
  def start_link(name, topic) do
    GenServer.start_link(__MODULE__, [topic], name: name)
  end

  def publish(name, message) do
    GenServer.cast(name, {:publish, message})
  end

  def init(topic) do
    [topic | _] = topic
    rabbitmq_connect(topic)
  end

  defp rabbitmq_connect(topic) do
    case AMQP.Connection.open([host: System.get_env("BROKER_HOST"), port: 5672]) do
      {:ok, connection} ->
        {:ok, connection} = AMQP.Connection.open host: System.get_env("BROKER_HOST"), port: 5672
        {:ok, channel} = AMQP.Channel.open(connection)
        AMQP.Queue.declare(channel, topic)
        {:ok, %{channel: channel, connection: connection, topic: topic} }
      {:error, _} ->
        IO.puts "Reconnecting to RabbitMQ..."
        # Reconnection loop
        :timer.sleep(1000)
        rabbitmq_connect(topic)
    end
  end

  def handle_cast({:publish, message}, state) do
    AMQP.Basic.publish(state.channel, "", state.topic, Poison.encode!(message))
    {:noreply, state}
  end

  def terminate(_reason, state) do
    AMQP.Connection.close(state.connection)
  end

end
