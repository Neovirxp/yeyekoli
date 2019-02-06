# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :yeyekoli_api,
  ecto_repos: [YeyekoliApi.Repo]

# Configures the endpoint
config :yeyekoli_api, YeyekoliApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MFcWkueCIGmVEVls4FC0pBObF/67aV7T6bUhUR0oL5FOuTKxH/Y6pk5sqgt9Rtcw",
  render_errors: [view: YeyekoliApiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: YeyekoliApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
