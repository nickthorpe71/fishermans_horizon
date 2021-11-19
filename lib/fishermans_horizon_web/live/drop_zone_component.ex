defmodule FishermansHorizonWeb.PageLive.DropZoneComponent do
  use Phoenix.LiveComponent

  @impl true

  def render(assigns) do
    ~L"""
      <div class="fish-bucket dropzone grid grid-cols-3 gap-3 p-2 border-solid border-2 opacity-10 border-<%= @color %>-500 rounded-md my-6" id="<%= @drop_zone_id %>">
        <%=  for %{name: name, id: id} <- @draggables do %>
          <%= live_component @socket, FishermansHorizonWeb.PageLive.FishComponent,
              id: id,
              name: name
          %>
        <% end %>
      </div>
    """
  end
end
