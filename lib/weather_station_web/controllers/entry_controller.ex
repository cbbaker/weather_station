defmodule WeatherStationWeb.EntryController do
  use WeatherStationWeb, :controller

  alias WeatherStation.Logs

  def index(conn, _params) do
    entries = Logs.list_entries()
    render(conn, "index.html", entries: entries)
  end

  def create(conn, %{"entry" => entry_params}) do
    case Logs.create_entry(entry_params) do
      {:ok, _entry} ->
        conn
        |> put_flash(:info, "Entry created successfully.")
        |> redirect(to: entry_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
