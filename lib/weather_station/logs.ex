defmodule WeatherStation.Logs do
  use GenServer

  defstruct [:device_id, :message, :created_at]

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], name: Logs)
  end

  def clear_entries() do
    GenServer.cast(Logs, :clear_entries)
  end


  def list_entries() do
    GenServer.call(Logs, :list_entries)
  end

  def create_entry(%{device_id: device_id, message: message}) do
    GenServer.call(Logs, {:create_entry, 
                          %WeatherStation.Logs{
                            created_at: System.os_time(),
                            device_id: device_id,
                            message: message
                          }})
  end

  def create_entry(%{"device_id" => device_id, "message" => message}) do
    GenServer.call(Logs, {:create_entry, 
                          %WeatherStation.Logs{
                            created_at: DateTime.utc_now,
                            device_id: device_id,
                            message: message
                          }})
  end


  def handle_cast(:clear_entries, _entries) do
    {:noreply, []}
  end


  def handle_call(:list_entries, _from, entries) do
    {:reply, entries, entries}
  end

  def handle_call({:create_entry, entry}, _from, entries) do
    {:reply, {:ok, entry}, [entry | entries]}
  end



end
