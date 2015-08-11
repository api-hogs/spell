defmodule Spell.MessageController do
  use Spell.Web, :controller
  use Spell.Authorization

  plug :authorize

  def index(conn, _params) do
    render conn, "index.json", messages: []
  end
end
