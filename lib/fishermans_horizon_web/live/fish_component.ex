defmodule FishermansHorizonWeb.PageLive.FishComponent do
  use Phoenix.LiveComponent

  @impl true

  def render(assigns) do
    ~L"""
      <div draggable="true" id="<%= @id %>" class="<%= @name %> place-items-center draggable text-white"/>
    """
  end
end
