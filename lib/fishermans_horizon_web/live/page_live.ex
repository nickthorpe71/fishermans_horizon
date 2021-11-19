defmodule FishermansHorizonWeb.PageLive.Playing do
  use FishermansHorizonWeb, :live_view

  @impl true

  def mount(_params, _session, socket) do
    all_fish = [
      %{id: "drag-me-0", name: "angler", weight: 80},
      %{id: "drag-me-1", name: "bass", weight: 55},
      %{id: "drag-me-2", name: "cod", weight: 110},
      %{id: "drag-me-3", name: "ray", weight: 65},
      %{id: "drag-me-4", name: "shark", weight: 182},
      %{id: "drag-me-5", name: "sunfish", weight: 148},
      %{id: "drag-me-6", name: "trout", weight: 165},
      %{id: "drag-me-7", name: "walleye", weight: 23}
    ]

    socket =
      socket
      |> assign(:all_fish, all_fish)
      |> assign(:fish, new_batch_of_fish(all_fish))
      |> assign(:fisherman_a, [])
      |> assign(:score, 0)
      |> assign(:state, 0)

    {:ok, socket}
  end

  def random_fish(all_fish, id) do
    random_index = :rand.uniform(Enum.count(all_fish)) - 1
    fish = Enum.at(all_fish, random_index)
    %{id: "drag-me-#{id}", name: fish.name, weight: fish.weight}
  end

  def new_batch_of_fish(all_fish) do
    Enum.map(0..17, fn i -> random_fish(all_fish, i) end)
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
      [:fish, :fisherman_a]
      |> Enum.find(fn zone_atom -> to_string(zone_atom) == drop_zone_id end)

    if drop_zone_atom === nil do
      throw("invalid drop_zone_id")
    end

    dragged = find_dragged(assigns, dragged_id)

    socket =
      [:fish, :fisherman_a]
      |> Enum.reduce(socket, fn zone_atom, %{assigns: assigns} = accumulator ->
        updated_list =
          assigns
          |> update_list(zone_atom, dragged, drop_zone_atom, draggable_index)

        accumulator
        |> assign(zone_atom, updated_list)
      end)

    {:noreply, socket |> haul_catch(Enum.count(assigns.fisherman_a))}
  end

  def haul_catch(socket, count)
      when count < 2 do
    socket
  end

  def haul_catch(socket, count)
      when count >= 2 do
    socket
    |> add_score
    |> assign(fisherman_a: [])
    |> add_new_fish
  end

  def add_new_fish(%{assigns: %{all_fish: all_fish}} = socket) do
    assign(socket,
      fish: new_batch_of_fish(all_fish)
    )
  end

  def add_score(%{assigns: %{score: score, fisherman_a: fisherman_a}} = socket) do
    matching = Enum.filter(fisherman_a, fn fish -> fish.name == Enum.at(fisherman_a, 0).name end)

    multiplier =
      if Enum.count(matching) >= 3 do
        # show multiplier on screen
        IO.puts("Multiplier!")
        2
      else
        1
      end

    assign(socket,
      score: Enum.reduce(fisherman_a, score, fn fish, acc -> acc + fish.weight end) * multiplier
    )
  end

  defp find_dragged(%{fish: fish, fisherman_a: fisherman_a}, dragged_id) do
    (fish ++ fisherman_a)
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

  def test_list(list) do
    list
    |> Enum.each(fn item -> IO.puts(item.name) end)
  end

  def remove_dragged(list, dragged_id) do
    list
    |> Enum.filter(fn draggable ->
      draggable.id != dragged_id
    end)
  end
end
