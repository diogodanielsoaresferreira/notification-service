defmodule NotificationsWeb.UserController do
  use NotificationsWeb, :controller

  alias Notifications.PointOfContact
  alias Notifications.PointOfContact.User

  action_fallback NotificationsWeb.FallbackController

  def index(conn, _params) do
    users = PointOfContact.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, user_params) do
    with {:ok, %User{} = user} <- PointOfContact.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = PointOfContact.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, params) do
    user = PointOfContact.get_user!(params["id"])

    with {:ok, %User{} = user} <- PointOfContact.update_user(user, params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = PointOfContact.get_user!(id)
    with {:ok, %User{}} <- PointOfContact.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
