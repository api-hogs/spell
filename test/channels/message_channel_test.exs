defmodule Spell.MessageChannelTest do
  use Spell.ChannelCase

  alias Spell.MessageChannel
  alias Spell.Redis

  @endpoint Spell.Endpoint

  setup do
    Redis.set("token1", 1)
    Redis.set("token2", 2)

    {:ok, _, socket_1} =
    socket("/api/v1/chat", %{})
    |> subscribe_and_join(MessageChannel, "messages:1", %{"token" => "token1"})

    {:ok, _, socket_2} =
    socket("/api/v1/chat", %{})
    |> subscribe_and_join(MessageChannel, "messages:2", %{"token" => "token2"})

    on_exit fn ->
      Redis.del("token1")
      Redis.del("token2")
    end

    {:ok, socket_1: socket_1, socket_2: socket_2}
  end

  test "message_sent", %{socket_1: socket_1} do
    push socket_1, "message_sent", %{"body" => "Hello", "recipient_id" => 2}
    message = %{sender_id: 1, recipient_id: 2, read: false, body: "Hello"}
    assert_broadcast "message_sent", message
    assert_broadcast "message_received", message
  end
end
