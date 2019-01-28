# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :notifications,
  ecto_repos: [Notifications.Repo]

# Configures the endpoint
config :notifications, NotificationsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "h6cbvfFhct9ZsSIucOaWqgQT136BNqqh7A2bpJKvmqU5EmWT6P1GxGzsrvNMgfr+",
  render_errors: [view: NotificationsWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Notifications.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
