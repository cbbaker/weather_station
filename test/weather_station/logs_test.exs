defmodule WeatherStationTest do
  use ExUnit.Case

  alias WeatherStation.Logs

  describe "list_entries" do
    test "lists all entries" do
      Logs.clear_entries
      entries = Logs.list_entries
      assert entries == []
    end
  end

  describe "create_entry" do
    test "adds an entry" do
      Logs.clear_entries
      Logs.create_entry(%{"message" => "test", "device_id" => 2})
      assert [%{message: "test", device_id: 2}] = Logs.list_entries
    end

    test "adds a timestamp" do
      Logs.clear_entries
      Logs.create_entry(%Logs{message: "test", device_id: 2})
      assert [%{created_at: _created_at}] = Logs.list_entries
    end
  end


end
