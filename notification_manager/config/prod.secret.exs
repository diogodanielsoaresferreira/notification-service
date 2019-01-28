use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :notifications, NotificationsWeb.Endpoint,
  secret_key_base: "9uhUyvYjW/VEtSU8hPXskT5so4YsRR3KOJqnZzWndUfqK73VhIB6O1n4U3aFEm7l"

#Configure your database
config :notifications, Notifications.Repo,
  adapter: Ecto.Adapters.Postgres,
  hostname: "PostgreSQL",
  username: "postgres",
  password: "postgres",
  database: "notifications_prod",
  pool_size: 15

# config :notifications, Notifications.Repo,
#   adapter: Sqlite.Ecto2,
#   database: "prod.sqlite3"


# Set Broker configurations
System.put_env("BROKER_HOST", "rabbitmq")