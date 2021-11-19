defmodule FishermansHorizon.StoreFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FishermansHorizon.Store` context.
  """

  @doc """
  Generate a score.
  """
  def score_fixture(attrs \\ %{}) do
    {:ok, score} =
      attrs
      |> Enum.into(%{
        score: "some score",
        user_name: "some user_name"
      })
      |> FishermansHorizon.Store.create_score()

    score
  end
end
