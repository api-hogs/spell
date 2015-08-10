defmodule Spell.RedisTest do
  use ExUnit.Case

  alias Spell.Redis

  test "get/set/del" do
    key = "test_key"
    Redis.del(key)
    assert Redis.get(key) == :undefined
    assert Redis.set(key, 42) == :ok
    assert Redis.get(key) == "42"
    assert Redis.del(key) == 1
    assert Redis.get(key) == :undefined
    assert Redis.del(key) == 0
  end
end
