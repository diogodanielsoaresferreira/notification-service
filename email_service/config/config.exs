# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure your application as:
#
#     config :email_service, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:email_service, :key)
#
# You can also configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env()}.exs"

# In your config/config.exs file
config :email_service, EmailService.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.gmail.com",
  port: 465,
  username: "chargeit.electricchargingsystem@gmail.com", # or {:system, "SMTP_USERNAME"}
  password: "ServiceEngineering", # or {:system, "SMTP_PASSWORD"}
  tls: :if_available, # can be `:if_available` or `:never`
  allowed_tls_versions: [:"tlsv1", :"tlsv1.1", :"tlsv1.2"], # or {":system", ALLOWED_TLS_VERSIONS"} w/ comma seprated values (e.g. "tlsv1.1,tlsv1.2")
  ssl: true, # can be `true`
  retries: 1,
  no_mx_lookups: false, # can be `true`
  auth: :if_available # can be `always`. If your smtp relay requires authentication set it to `always`.

System.put_env("BROKER_HOST", "rabbitmq")
