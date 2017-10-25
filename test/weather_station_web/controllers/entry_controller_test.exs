defmodule WeatherStationWeb.EntryControllerTest do
  use WeatherStationWeb.ConnCase

  alias WeatherStation.Logs

  @create_attrs %Logs{device_id: 42, message: "some message"}

  def fixture(:entry) do
    {:ok, entry} = Logs.create_entry(@create_attrs)
    entry
  end

  describe "index" do
    test "lists all entries", %{conn: conn} do
      conn = get conn, entry_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Entries"
    end
  end

  describe "create entry" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, entry_path(conn, :create), entry: @create_attrs

      assert %{} = redirected_params(conn)
      assert redirected_to(conn) == entry_path(conn, :index)
    end
  end
end
