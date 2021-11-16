defmodule FishermansHorizonWeb.PageController do
  use FishermansHorizonWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
