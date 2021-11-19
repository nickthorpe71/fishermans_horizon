defmodule FishermansHorizonWeb.PageLive.GameOver do
  use FishermansHorizonWeb, :live_view

  def mount(params, _session, socket) do
    {
      :ok,
      assign(socket, score: params["score"])
    }
  end

  defp restart(socket) do
    push_redirect(socket, to: "/")
  end

  def handle_event("restart", _, socket) do
    {:noreply, restart(socket)}
  end
end
