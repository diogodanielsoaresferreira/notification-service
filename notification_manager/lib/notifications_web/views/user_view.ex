defmodule NotificationsWeb.UserView do
  use NotificationsWeb, :view
  alias NotificationsWeb.UserView

  def render("index.json", %{users: users}) do
    render_many(users, UserView, "user.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      phone: user.phone,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at,
      sms_enabled: user.sms_enabled,
      app_enabled: user.app_enabled,
      email_enabled: user.email_enabled,
      apikey: user.apikey}
  end
end
