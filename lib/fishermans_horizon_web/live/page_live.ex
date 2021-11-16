defmodule FishermansHorizonWeb.PageLive do
  use FishermansHorizonWeb, :live_view

  @impl true

  def mount(_params, _session, socket) do
    # this is hardcoded but will eventually be from a datasource
    fish = [
      %{id: "drag-me-0", name: "Carp", weight: "8.8 lbs"},
      %{id: "drag-me-0", name: "Perch", weight: "5.8 lbs"},
      %{id: "drag-me-0", name: "Bass", weight: "11.0 lbs"},
      %{id: "drag-me-0", name: "Walleye", weight: "6.5 lbs"},
      %{id: "drag-me-0", name: "Pike", weight: "8.2lbs"},
      %{id: "drag-me-0", name: "Trout", weight: "14.8lbs"},
      %{id: "drag-me-0", name: "red fish", weight: "8.8lbs"}
    ]

    socket =
      socket
      |> assign(:pool, fish)
      |> assign(:fisherman_a, [])
      |> assign(:fisherman_b, [])

    {:ok, socket}
  end
end
