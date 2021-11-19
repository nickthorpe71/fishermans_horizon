defmodule FishermansHorizonWeb.PageLive.GameOver do
  use FishermansHorizonWeb, :live_view
  alias FishermansHorizon.Store

  def mount(params, _session, socket) do
    score = params["score"]
    user = params["user"]
    Store.create_score(%{score: score, user_name: user})

    {
      :ok,
      assign(socket,
        user: user,
        score: score,
        scores: Store.list_scores() |> filter_scores
      )
    }
  end

  def filter_scores(scores) do
    scores
    |> Enum.sort_by(fn s -> Integer.parse(s.score) end)
    |> Enum.reverse()
    |> last_ten_or_less(Enum.count(scores))
  end

  def last_ten_or_less(list, count) when count < 10 do
    list
    |> Enum.take(count)
  end

  def last_ten_or_less(list, _count) do
    list
    |> Enum.take(10)
  end

  defp restart(%{assigns: %{user: user}} = socket) do
    push_redirect(socket, to: "/playing?user=#{user}")
  end

  def handle_event("restart", _, socket) do
    {:noreply, restart(socket)}
  end
end
