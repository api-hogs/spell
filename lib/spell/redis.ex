defmodule Spell.Redis do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def set(key, value) do
    GenServer.call(__MODULE__, {:set, key, value})
  end

  def del(key) do
    GenServer.call(__MODULE__, {:del, key})
  end

  def init([]) do
    {:ok, _client} = Exredis.start_link
  end

  def handle_call({:get, key}, _from, client) do
    value = Exredis.Api.get(client, key)
    {:reply, value, client}
  end

  def handle_call({:set, key, value}, _from, client) do
    resp = Exredis.Api.set(client, key, value)
    {:reply, resp, client}
  end

  def handle_call({:del, key}, _from, client) do
    resp = Exredis.Api.del(client, key)
    {:reply, resp, client}
  end

  def terminate(_reason, client) do
    Exredis.stop(client)
    :ok
  end
end
