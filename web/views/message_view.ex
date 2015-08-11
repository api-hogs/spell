defmodule Spell.MessageView do
  use Spell.Web, :view

  def render("index.json", %{messages: messages}) do
    Enum.map(messages, &serialize/1)
  end

  def render("unauthorized.json", %{}) do
    %{error: "unauthorized"}
  end

  def serialize(message) do
    Map.take(message, [:id, :body, :read, :sender_id, :recipient_id])
  end
end
