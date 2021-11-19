defmodule FishermansHorizon.Repo.Migrations.CreateScores do
  use Ecto.Migration

  def change do
    create table(:scores) do
      add :user_name, :string
      add :score, :string

      timestamps()
    end
  end
end
