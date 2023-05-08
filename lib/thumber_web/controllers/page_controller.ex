defmodule ThumberWeb.PageController do
  use ThumberWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: "/api/swagger")
  end
end
