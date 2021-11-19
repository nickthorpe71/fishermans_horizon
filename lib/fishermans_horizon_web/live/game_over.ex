defmodule FishermansHorizonWeb.PageLive.GameOver do
  use FishermansHorizonWeb, :live_view
  alias FishermansHorizon.Store

  def mount(params, _session, socket) do
    {
      :ok,
      assign(socket, score: params["score"], scores: Store.list_scores() |> filter_scores)
    }
  end

  def filter_scores(scores) do
    scores
    |> Enum.sort_by(&Map.fetch(&1, :score))
    |> Enum.take(10)
  end

  defp submit_score(%{assigns: %{score: score}} = socket) do
    Store.create_score(%{score: "#{score}", user_name: "test name"})
    push_redirect(socket, to: "/playing")
  end

  def handle_event("restart", _, socket) do
    {:noreply, submit_score(socket)}
  end
end
