defmodule FishermansHorizonWeb.PageLive.Welcome do
  use FishermansHorizonWeb, :live_view
  alias FishermansHorizon.Game

  def mount(_params, _session, socket) do
    {
      :ok,
      assign(socket, game: Map.get(socket.assigns, :game) || Game.new())
    }
  end

  defp play(socket) do
    push_redirect(socket, to: "/playing")
  end

  def handle_event("play", _, socket) do
    {:noreply, play(socket)}
  end
end
