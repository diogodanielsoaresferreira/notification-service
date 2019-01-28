defmodule NotificationsWeb.Router do
  use NotificationsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v0.1", NotificationsWeb do
    pipe_through :api
    resources "/notifications", NotificationController, only: [:index, :show, :create]
    resources "/users", UserController, only: [:show, :create, :update, :delete]
  end
end
