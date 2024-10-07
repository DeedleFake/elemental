defmodule Elemental.Repo do
  use Ecto.Repo,
    otp_app: :elemental,
    adapter: Ecto.Adapters.Postgres
end
