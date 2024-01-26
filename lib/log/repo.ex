defmodule Log.Repo do
  use Ecto.Repo,
    otp_app: :log,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 13
end
