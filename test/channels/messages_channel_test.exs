defmodule Spell.MessagesChannelTest do
  use Spell.ChannelCase

  alias Spell.MessagesChannel
  alias Spell.Repo
  alias Spell.User
  alias Spell.Message

  setup do
    {:ok, user_1} = Repo.insert(User.changeset(%User{}, %{name: "One"}))
    {:ok, user_2} = Repo.insert(User.changeset(%User{}, %{name: "Two"}))

    {:ok, _, socket_1} = subscribe_and_join(MessagesChannel,
    "messages:" <> to_string(user_1.id), %{"user_id" => user_1.id})

    {:ok, _, socket_2} = subscribe_and_join(MessagesChannel,
    "messages:" <> to_string(user_2.id), %{"user_id" => user_2.id})

    {:ok, socket_1: socket_1, socket_2: socket_2, user_1: user_1, user_2: user_2}
  end

  test "message_sent", %{socket_1: socket_1, user_2: user_2} do
    push socket_1, "message_sent", %{"body" => "Hello", "recipient_id" => user_2.id}
    assert_broadcast "message_sent", %Message{}
    assert_broadcast "message_received", %Message{}
  end
end
