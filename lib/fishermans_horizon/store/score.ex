defmodule FishermansHorizon.Store.Score do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scores" do
    field :score, :string
    field :user_name, :string

    timestamps()
  end

  @doc false
  def changeset(score, attrs) do
    score
    |> cast(attrs, [:user_name, :score])
    |> validate_required([:user_name, :score])
  end
end
