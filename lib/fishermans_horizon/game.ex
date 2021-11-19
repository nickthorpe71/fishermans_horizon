defmodule FishermansHorizon.Game do
  defstruct score: 0, time: 0, fish: [], fisherman_a: [], game_over: false

  def new do
    __struct__()
    |> new_batch_of_fish
  end

  def new_batch_of_fish(game) do
    %{game | fish: gen_multiple_fish(18)}
  end

  def gen_multiple_fish(n) do
    Enum.map(0..(n - 1), fn i -> random_fish(i) end)
  end

  def random_fish(id) do
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

    random_index = :rand.uniform(Enum.count(all_fish)) - 1
    fish = Enum.at(all_fish, random_index)
    %{id: "drag-me-#{id}", name: fish.name, weight: fish.weight}
  end

  def haul_catch(game, count)
      when count < 3,
      do: game

  def haul_catch(game, count)
      when count >= 3 do
    %{game | score: total_score(game), fisherman_a: [], fish: gen_multiple_fish(18)}
  end

  def total_score(%{score: score, fisherman_a: fisherman_a}) do
    matching = Enum.filter(fisherman_a, fn fish -> fish.name == Enum.at(fisherman_a, 0).name end)

    multiplier =
      if Enum.count(matching) >= 3 do
        # show multiplier on screen
        2
      else
        1
      end

    Enum.reduce(fisherman_a, score, fn fish, acc -> acc + fish.weight end) * multiplier
  end

  def catch_fish(game, dragged, drop_zone_atom, draggable_index) do
    game
    |> update_fish(dragged, drop_zone_atom, draggable_index)
    |> update_fisherman(dragged, drop_zone_atom, draggable_index)
  end

  def update_fish(game, dragged, drop_zone_atom, draggable_index) do
    %{game | fish: update_list(game.fish, :fish, dragged, drop_zone_atom, draggable_index)}
  end

  def update_fisherman(game, dragged, drop_zone_atom, draggable_index) do
    %{
      game
      | fisherman_a:
          update_list(game.fisherman_a, :fisherman_a, dragged, drop_zone_atom, draggable_index)
    }
  end

  def update_list(list, list_atom, dragged, drop_zone_atom, draggable_index)
      when list_atom == drop_zone_atom do
    list
    |> remove_from_list(dragged.id)
    |> List.insert_at(draggable_index, dragged)
  end

  def update_list(list, list_atom, dragged, drop_zone_atom, _draggable_index)
      when list_atom != drop_zone_atom do
    list
    |> remove_from_list(dragged.id)
  end

  def remove_from_list(list, dragged_id) do
    list
    |> Enum.filter(fn draggable ->
      draggable.id != dragged_id
    end)
  end

  def update_time(game) do
    %{game | time: game.time + 1}
    |> check_game_over
  end

  def check_game_over(%{time: time} = game) when time >= 10 do
    %{game | game_over: true}
  end

  def check_game_over(game), do: game
end
