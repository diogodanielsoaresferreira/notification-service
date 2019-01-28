defmodule NotificationsWeb.NotificationController do
  use NotificationsWeb, :controller

  alias Notifications.Messages
  alias Notifications.Messages.Notification
  alias Notifications.Repo
  action_fallback NotificationsWeb.FallbackController

  def index(conn, _params) do
    id = conn.params["user_id"]
    start_date = conn.params["start_date"]
    end_date = conn.params["end_date"]

    notifications = Notification
      |> Messages.query
      |> Messages.filter_by_user_id(id)
      |> Messages.filter_by_start_date(start_date)
      |> Messages.filter_by_end_date(end_date)
      |> Repo.all

    render(conn, "index.json", notifications: notifications)
  end

  def create(conn, notification_params) do
    with {:ok, %Notification{} = notification} <- Messages.create_notification(notification_params) do

      notification = notification |> Repo.preload([:user])

      if notification.app do
        message = %Notifications.Message{address: notification.user.apikey, message: notification.content, title: notification.title}
        Notifications.MessageToBrokerWorker.publish(:App, message)
      end
      
      if notification.sms do
        message = %Notifications.Message{address: notification.user.phone, message: notification.content, title: notification.title}
        Notifications.MessageToBrokerWorker.publish(:SMS, message)
      end

      if notification.email do
        message = %Notifications.Message{address: notification.user.email, message: notification.content, title: notification.title}
        Notifications.MessageToBrokerWorker.publish(:Email, message)
      end

      conn
      |> put_status(:created)
      |> put_resp_header("location", notification_path(conn, :show, notification))
      |> render("show.json", notification: notification)
    end
  end

  def show(conn, %{"id" => id}) do
    notification = Messages.get_notification!(id)
    render(conn, "show.json", notification: notification)
  end


  def update(conn, %{"id" => id, "notification" => notification_params}) do
    notification = Messages.get_notification!(id)

    with {:ok, %Notification{} = notification} <- Messages.update_notification(notification, notification_params) do
      render(conn, "show.json", notification: notification)
    end
  end

  def delete(conn, %{"id" => id}) do
    notification = Messages.get_notification!(id)
    with {:ok, %Notification{}} <- Messages.delete_notification(notification) do
      send_resp(conn, :no_content, "")
    end
  end
end
