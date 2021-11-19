defmodule FishermansHorizonWeb.PageLive.FishComponent do
  use Phoenix.LiveComponent

  @impl true

  def render(assigns) do
    ~L"""
      <div draggable="true" id="<%= @id %>" class="place-items-center draggable text-white"><img src="/images/Resized/<%= @name %>.png"/></div>
    """
  end
end
