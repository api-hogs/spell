defmodule Spell.MessageController do
  use Spell.Web, :controller
  use Spell.Authorization

  plug :authorize

  def index(conn, params) do
    messages = case params["user_id"] do
      nil -> []
      user_id -> Spell.Message.between(conn.assigns.user_id, user_id)
    end
    render conn, "index.json", messages: messages
  end
end
