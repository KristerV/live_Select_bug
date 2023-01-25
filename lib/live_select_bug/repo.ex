defmodule LiveSelectBug.Repo do
  use Ecto.Repo,
    otp_app: :live_select_bug,
    adapter: Ecto.Adapters.Postgres
end
