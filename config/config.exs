# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :lernmit,
  ecto_repos: [Lernmit.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :lernmit, LernmitWeb.Endpoint,
  url: [
    host: System.get_env("HOSTNAME"),
    port: 443,
    scheme: "https"
  ],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: LernmitWeb.ErrorHTML, json: LernmitWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Lernmit.PubSub,
  live_view: [signing_salt: "4xmMjVUW"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :lernmit, Lernmit.Mailer, adapter: Swoosh.Adapters.Local

# esbuild
config :esbuild,
  version: "0.17.11",
  lernmit: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# tailwind
config :tailwind,
  version: "3.4.3",
  lernmit: [
    args: ~w(
      --config=tailwind.config.js
      --input=../priv/static/assets/app.css.tailwind
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# dart_sass
config :dart_sass,
  version: "1.77.8",
  lernmit: [
    args: ~w(css/app.scss ../priv/static/assets/app.css.tailwind),
    cd: Path.expand("../assets", __DIR__)
  ]

config :lernmit, :pow,
  web_module: LernmitWeb,
  user: Lernmit.Users.User,
  repo: Lernmit.Repo

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :lernmit, LernmitWeb.Gettext, locales: ~w(de en), default_locale: "de"

# Runtime configuration (defaults for all environments)
# PowAssent (OAuth2 provider)
config :lernmit, :pow_assent,
  providers: [
    Keycloak: [
      client_id: System.get_env("OAUTH_CLIENT_ID"),
      client_secret: System.get_env("OAUTH_CLIENT_SECRET"),
      strategy: Lernmit.Auth.Provider
    ]
  ]

# S3
config :lernmit,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  bucket: System.get_env("S3_BUCKET"),
  region: System.get_env("AWS_REGION"),
  url: System.get_env("S3_URL"),
  host: System.get_env("S3_ALIAS_HOST")

# Backpex
config :backpex, :pubsub_server, Lernmit.PubSub

# Sentry
config :sentry,
  dsn:
    "https://f1d98c8bf4a61cb1bc28f47c6e0bdc2d@o4506923162533888.ingest.us.sentry.io/4508278133882880",
  environment_name: Mix.env(),
  enable_source_code_context: true,
  root_source_code_paths: [File.cwd!()]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
