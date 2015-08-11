defmodule Spell.MessageControllerTest do
  use Spell.ConnCase
  alias Spell.Redis

  setup do
    Redis.set("token", "1")

    on_exit fn ->
      Redis.del("token")
    end
  end

  test "GET /api/messages without token" do
    conn = get conn(), "/api/messages"
    assert conn.status == 401
  end

  test "GET /api/messages with wrong token" do
    conn = conn()
    |> put_req_header("authorization", "Token token=wrong")
    |> get "/api/messages"
    assert conn.status == 401
  end

  test "GET /api/messages with correct token" do
    conn = conn()
    |> put_req_header("authorization", "Token token=token")
    |> get "/api/messages"
    assert conn.status == 200
  end
end
