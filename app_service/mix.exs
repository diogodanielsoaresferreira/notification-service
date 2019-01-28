defmodule AppService.MixProject do
  use Mix.Project

  def project do
    [
      app: :app_service,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {AppService, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:amqp, "~> 1.0"},
      {:ranch_proxy_protocol, "~> 2.0", override: true},
      {:poison, "~> 3.1"},
      {:fcmex, "~> 0.3.0"}
    ]
  end
end
