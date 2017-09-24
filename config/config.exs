# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :escala,
  ecto_repos: [Escala.Repo]

# Configures the endpoint
config :escala, EscalaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "U/Ciuyr4ddDt9Gw2CgbSGZhsOjudBGKtP7CTCpoxbZ/JLo+QoYOIGBUpC0241wuP",
  render_errors: [view: EscalaWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Escala.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]


config :guardian, Guardian,
  allowed_algos: ["HS512", "HS384"],
  issuer: "Escala",
  ttl: { 1, :year },
  serializer: Escala.GuardianSerializer,
  secret_key: "1VyYiQtshlM6GEeUxKF69ZO2Y9UfaS/kmeg/cU74w7UyqZFQAw+HKfkYAi33AkV1"


config :escala, EscalaWeb.Gettext,
  default_locale: "fa"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
