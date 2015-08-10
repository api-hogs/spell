defmodule Spell.MessageChannelTest do
  use Spell.ChannelCase

  alias Spell.MessageChannel
  alias Spell.Repo
  alias Spell.Message

  setup do
    {:ok, _, socket_1} = subscribe_and_join(MessageChannel, "messages:1",
    %{"user_id" => 1})

    {:ok, _, socket_2} = subscribe_and_join(MessageChannel, "messages:2",
    %{"user_id" => 2})

    {:ok, socket_1: socket_1, socket_2: socket_2}
  end

  test "message_sent", %{socket_1: socket_1} do
    push socket_1, "message_sent", %{"body" => "Hello", "recipient_id" => 2}
    message = %{sender_id: 1, recipient_id: 2, read: false, body: "Hello"}
    assert_broadcast "message_sent", message
    assert_broadcast "message_received", message
  end
end
