defmodule Spell.MessageTest do
  use Spell.ModelCase

  alias Spell.Message

  @valid_attrs %{body: "some content", read: true, recipient_id: 1, sender_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Message.changeset(%Message{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Message.changeset(%Message{}, @invalid_attrs)
    refute changeset.valid?
  end
end
