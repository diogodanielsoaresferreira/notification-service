defmodule NotificationsWeb.NotificationView do
  use NotificationsWeb, :view
  alias NotificationsWeb.NotificationView

  def render("index.json", %{notifications: notifications}) do
    render_many(notifications, NotificationView, "notification.json")
  end

  def render("show.json", %{notification: notification}) do
    render_one(notification, NotificationView, "notification.json")
  end

  def render("notification.json", %{notification: notification}) do
    %{id: notification.id,
      title: notification.title,
      content: notification.content,
      app: notification.app,
      sms: notification.sms,
      email: notification.email,
      timestamp: notification.inserted_at,
      user_id: notification.user_id}
  end
end
