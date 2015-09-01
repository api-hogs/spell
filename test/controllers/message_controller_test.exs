defmodule Spell.MessageControllerTest do
  use Spell.ConnCase

  setup do
    Spell.Redis.set("token", 1)

    on_exit fn ->
      Spell.Redis.del("token")
    end
  end

  defp authorized_conn do
    put_req_header(conn(), "authorization", "Token token=token")
  end

  defp create_message(from, to) do
    {:ok, message} = Spell.Repo.insert(
    %Spell.Message{recipient_id: to, sender_id: from, body: "Hi"})
    message
  end

  test "GET /api/v1/chat/messages without token" do
    conn = conn()
            |> get("/api/v1/chat/messages")
            |> doc
    assert conn.status == 401
  end

  test "GET /api/v1/chat/messages with wrong token" do
    conn = conn()
            |> put_req_header("authorization", "Token token=wrong")
            |> get("/api/v1/chat/messages")
            |> doc
    assert conn.status == 401
  end

  test "GET /api/v1/chat/messages with correct token" do
    conn = authorized_conn()
            |> get("/api/v1/chat/messages")
            |> doc
    assert conn.status == 200
  end

  test "GET /api/v1/chat/messages returns chat history" do
    create_message(1, 2)
    create_message(2, 1)
    conn = authorized_conn()
            |> get("/api/v1/chat/messages?user_id=2")
            |> doc
    {:ok, resp} = Poison.decode(conn.resp_body)
    assert length(resp) == 2
  end
end
