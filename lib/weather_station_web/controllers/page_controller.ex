defmodule WeatherStationWeb.PageController do
  use WeatherStationWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
