defmodule Spell.Authorization do
  defmacro __using__([]) do
    quote do
      defp authorize(conn, _params) do
        case Plug.Conn.get_req_header(conn, "authorization") do
          ["Token token=" <> token] ->
            case Spell.Redis.get(token) do
              :undefined -> unauthorized(conn)
              user_id -> assign(conn, :user_id, user_id)
            end
            _ -> unauthorized(conn)
        end
      end

      defp unauthorized(conn) do
        conn
        |> put_status(:unauthorized)
        |> render(:unauthorized)
        |> halt
      end
    end
  end
end
