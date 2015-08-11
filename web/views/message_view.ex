defmodule Spell.MessageView do
  use Spell.Web, :view

  def render("index.json", %{messages: messages}) do
    messages
  end

  def render("unauthorized.json", %{}) do
    %{error: "unauthorized"}
  end
end
