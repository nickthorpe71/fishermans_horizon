defmodule FishermansHorizon.StoreTest do
  use FishermansHorizon.DataCase

  alias FishermansHorizon.Store

  describe "scores" do
    alias FishermansHorizon.Store.Score

    import FishermansHorizon.StoreFixtures

    @invalid_attrs %{score: nil, user_name: nil}

    test "list_scores/0 returns all scores" do
      score = score_fixture()
      assert Store.list_scores() == [score]
    end

    test "get_score!/1 returns the score with given id" do
      score = score_fixture()
      assert Store.get_score!(score.id) == score
    end

    test "create_score/1 with valid data creates a score" do
      valid_attrs = %{score: "some score", user_name: "some user_name"}

      assert {:ok, %Score{} = score} = Store.create_score(valid_attrs)
      assert score.score == "some score"
      assert score.user_name == "some user_name"
    end

    test "create_score/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_score(@invalid_attrs)
    end

    test "update_score/2 with valid data updates the score" do
      score = score_fixture()
      update_attrs = %{score: "some updated score", user_name: "some updated user_name"}

      assert {:ok, %Score{} = score} = Store.update_score(score, update_attrs)
      assert score.score == "some updated score"
      assert score.user_name == "some updated user_name"
    end

    test "update_score/2 with invalid data returns error changeset" do
      score = score_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_score(score, @invalid_attrs)
      assert score == Store.get_score!(score.id)
    end

    test "delete_score/1 deletes the score" do
      score = score_fixture()
      assert {:ok, %Score{}} = Store.delete_score(score)
      assert_raise Ecto.NoResultsError, fn -> Store.get_score!(score.id) end
    end

    test "change_score/1 returns a score changeset" do
      score = score_fixture()
      assert %Ecto.Changeset{} = Store.change_score(score)
    end
  end
end
