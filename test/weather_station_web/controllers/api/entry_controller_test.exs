defmodule WeatherStationWeb.Api.EntryControllerTest do
  use WeatherStationWeb.ConnCase

  alias WeatherStation.Logs

  @create_attrs %{"device_id" => 42, "message" => "some message"}

  def fixture(:entry) do
    {:ok, entry} = Logs.create_entry(@create_attrs)
    entry
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all entries", %{conn: conn} do
      Logs.clear_entries()
      create_entry(:ok)
      conn = get conn, api_entry_path(conn, :index)
      assert [%{"created_at" => _created_at,
                "device_id" => _device_id,
                "message" => _message}] = json_response(conn, 200)["data"]
    end
  end

  describe "create entry" do
    test "renders entry when data is valid", %{conn: conn} do
      conn = post conn, api_entry_path(conn, :create), entry: @create_attrs
      assert "success" = response(conn, 201)
    end
  end

  defp create_entry(_) do
    entry = fixture(:entry)
    {:ok, entry: entry}
  end
end
