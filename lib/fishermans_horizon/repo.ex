defmodule FishermansHorizon.Repo do
  use Ecto.Repo,
    otp_app: :fishermans_horizon,
    adapter: Ecto.Adapters.Postgres
end
