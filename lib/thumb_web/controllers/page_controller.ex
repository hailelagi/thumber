defmodule ThumbWeb.PageController do
  use ThumbWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
