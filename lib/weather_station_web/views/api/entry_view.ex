defmodule WeatherStationWeb.Api.EntryView do
  use WeatherStationWeb, :view
  alias WeatherStationWeb.Api.EntryView

  def render("index.json", %{entries: entries}) do
    %{data: render_many(entries, EntryView, "entry.json")}
  end

  def render("show.json", %{entry: entry}) do
    %{data: render_one(entry, EntryView, "entry.json")}
  end

  def render("entry.json", %{entry: %{created_at: created_at,
                                      device_id: device_id,
                                      message: message}}) do
    %{created_at: created_at,
      device_id: device_id,
      message: message}
  end
end
