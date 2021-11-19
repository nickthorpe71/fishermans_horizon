defmodule FishermansHorizonWeb.PageLive.Playing do
  use FishermansHorizonWeb, :live_view
  alias FishermansHorizon.Game

  @impl true

  def mount(params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, :tick)
    end

    {:ok, socket |> new_game |> assign(user: params["user"])}
  end

  def new_game(socket) do
    assign(socket, game: Game.new())
  end

  @impl true
  def handle_event(
        "dropped",
        %{
          "draggedId" => dragged_id,
          "dropzoneId" => drop_zone_id,
          "draggableIndex" => draggable_index
        },
        %{assigns: assigns} = socket
      ) do
    dragged = find_dragged(assigns.game, dragged_id)

    {:noreply,
     socket
     |> catch_fish(dragged, String.to_atom(drop_zone_id), draggable_index)
     |> haul_catch}
  end

  def catch_fish(%{assigns: %{game: game}} = socket, dragged, drop_zone_atom, draggable_index) do
    assign(socket, game: Game.catch_fish(game, dragged, drop_zone_atom, draggable_index))
  end

  def haul_catch(%{assigns: %{game: game}} = socket) do
    assign(socket, game: Game.haul_catch(game, Enum.count(game.fisherman_a)))
  end

  defp find_dragged(%{fish: fish, fisherman_a: fisherman_a}, dragged_id) do
    (fish ++ fisherman_a)
    |> Enum.find(nil, fn draggable ->
      draggable.id == dragged_id
    end)
  end

  @impl true
  def handle_info(:tick, socket) do
    {:noreply, socket |> update_time |> maybe_end_game}
  end

  def update_time(%{assigns: %{game: game}} = socket) do
    assign(socket, game: Game.update_time(game))
  end

  def maybe_end_game(%{assigns: %{game: %{game_over: true}}} = socket) do
    socket
    |> push_redirect(
      to: "/gameover?user=#{socket.assigns.user}&score=#{socket.assigns.game.score}"
    )
  end

  def maybe_end_game(socket), do: socket
end
