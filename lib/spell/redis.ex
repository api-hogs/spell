defmodule Spell.Redis do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def init([]) do
    {:ok, client} = Exredis.start_link
  end

  def handle_call({:get, key}, _from, client) do
    value = Exredis.Api.get(client, key)
    {:reply, value, client}
  end

  def terminate(_reason, client) do
    Exredis.stop(client)
    :ok
  end
end
