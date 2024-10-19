defmodule Lernmit.Repo do
  use Ecto.Repo,
    otp_app: :lernmit,
    adapter: Ecto.Adapters.Postgres
end
