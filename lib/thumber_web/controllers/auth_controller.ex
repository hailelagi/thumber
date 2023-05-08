defmodule ThumberWeb.AuthController do
  use ThumberWeb, :controller

  def request(conn, _params) do
    render(conn, nil)
  end

def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
  user_data = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}

end
end
