defmodule Spell.MessageChannel do
  use Spell.Web, :channel

  alias Spell.Repo
  alias Spell.User
  alias Spell.Message

  def join("messages:" <> user_id, _payload, socket) do
    if authorized?(user_id) do
      {:ok, assign(socket, :user_id, user_id)}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("message_sent", payload, socket) do
    message = create_message(socket.assigns.user_id, payload)
    recipient_id = to_string(message.recipient_id)

    message = serialize_message(message)
    broadcast socket, "message_sent", message
    Spell.Endpoint.broadcast_from! self(), "messages:" <> recipient_id,
    "message_received", message

    {:noreply, socket}
  end

  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end

  defp authorized?(user_id) do
    Repo.get(User, user_id) != nil
  end

  defp create_message(user_id, payload) do
    payload = Map.put(payload, "sender_id", user_id)
    changeset = Message.changeset(%Message{}, payload)
    {:ok, message} = Repo.insert(changeset)
    message
  end

  def serialize_message(message) do
    Map.take(message, [:id, :body, :read, :sender_id, :recipient_id])
  end
end
