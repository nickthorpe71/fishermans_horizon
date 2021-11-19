defmodule FishermansHorizonWeb.PageLive.Welcome do
  use FishermansHorizonWeb, :live_view
  alias FishermansHorizon.Game

  def mount(_params, _session, socket) do
    {
      :ok,
      assign(socket, game: Map.get(socket.assigns, :game) || Game.new())
    }
  end

  defp play(socket, user) do
    push_redirect(socket, to: "/playing?user=#{user}")
  end

  def handle_event("play", %{"play" => %{"user" => user}}, socket) do
    {:noreply, play(socket, user)}
  end
end
