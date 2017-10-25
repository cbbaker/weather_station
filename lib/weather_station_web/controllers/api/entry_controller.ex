defmodule WeatherStationWeb.Api.EntryController do
  use WeatherStationWeb, :controller

  alias WeatherStation.Logs

  action_fallback WeatherStationWeb.FallbackController

  def index(conn, _params) do
    entries = Logs.list_entries()
    render(conn, "index.json", entries: entries)
  end

  def create(conn, %{"entry" => entry_params}) do
    with {:ok, _entry} <- Logs.create_entry(entry_params) do
      conn
      |> put_status(:created)
      |> text("success")
    end
  end
end
