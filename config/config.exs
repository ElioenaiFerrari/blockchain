# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :blockchain,
  ecto_repos: [Blockchain.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :blockchain, BlockchainWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "r6L/g8a2MaKf0L18SRYzRuvpEUtsGSs6lNoxFNqjBdWqDlLyUfKyCukjwKIirkg5",
  render_errors: [view: BlockchainWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Blockchain.PubSub,
  live_view: [signing_salt: "warZ57AI"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
