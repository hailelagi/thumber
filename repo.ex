defmodule Thumber.Repo do
  use Ecto.Repo,
    otp_app: :thumber,
    adapter: Ecto.Adapters.SQLite3
end
