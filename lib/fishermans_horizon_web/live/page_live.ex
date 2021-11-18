defmodule FishermansHorizonWeb.PageLive do
  use FishermansHorizonWeb, :live_view

  @impl true

  def mount(_params, _session, socket) do
    # this is hardcoded but will eventually be from a datasource
    fish = [
      %{id: "drag-me-0", name: "Carp", weight: "8.8 lbs"},
      %{id: "drag-me-1", name: "Perch", weight: "5.8 lbs"},
      %{id: "drag-me-2", name: "Bass", weight: "11.0 lbs"},
      %{id: "drag-me-3", name: "Walleye", weight: "6.5 lbs"},
      %{id: "drag-me-4", name: "Pike", weight: "8.2lbs"},
      %{id: "drag-me-5", name: "Trout", weight: "14.8lbs"}
    ]

    socket =
      socket
      |> assign(:fish, fish)
      |> assign(:fisherman_a, [])
      |> assign(:fisherman_b, [])

    {:ok, socket}
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
    drop_zone_atom =
      [:fish, :fisherman_a, :fisherman_b]
      |> Enum.find(fn zone_atom -> to_string(zone_atom) == drop_zone_id end)

    if drop_zone_atom === nil do
      throw("invalid drop_zone_id")
    end

    dragged = find_dragged(assigns, dragged_id)

    socket =
      [:fish, :fisherman_a, :fisherman_b]
      |> Enum.reduce(socket, fn zone_atom, %{assigns: assigns} = accumulator ->
        updated_list =
          assigns
          |> update_list(zone_atom, dragged, drop_zone_atom, draggable_index)

        accumulator
        |> assign(zone_atom, updated_list)
      end)

    {:noreply, socket}
  end

  defp find_dragged(%{fish: fish, fisherman_a: fisherman_a, fisherman_b: fisherman_b}, dragged_id) do
    (fish ++ fisherman_a ++ fisherman_b)
    |> Enum.find(nil, fn draggable ->
      draggable.id == dragged_id
    end)
  end

  def update_list(assigns, list_atom, dragged, drop_zone_atom, draggable_index)
      when list_atom == drop_zone_atom do
    assigns[list_atom]
    |> remove_dragged(dragged.id)
    |> List.insert_at(draggable_index, dragged)
  end

  def update_list(assigns, list_atom, dragged, drop_zone_atom, _draggable_index)
      when list_atom != drop_zone_atom do
    assigns[list_atom]
    |> remove_dragged(dragged.id)
  end

  def remove_dragged(list, dragged_id) do
    list
    |> Enum.filter(fn draggable ->
      draggable.id != dragged_id
    end)
  end
end
