defmodule Spell.PageController do
  use Spell.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
