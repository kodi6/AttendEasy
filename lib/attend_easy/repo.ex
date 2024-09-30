defmodule AttendEasy.Repo do
  use Ecto.Repo,
    otp_app: :attend_easy,
    adapter: Ecto.Adapters.Postgres
end
