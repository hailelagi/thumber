defmodule ThumberWeb.AuthController do
  use ThumberWeb, :controller

  alias Thumber.User.Sovereign
  alias Thumber.User
  alias Thumber.DynamicVault

  def request(conn, _params) do
    render(conn, nil)
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    # todo return OTP key on auth verification for opt in to sovereign
    access_key = generate_otp_key()
    user_data = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}

    case User.create_user(user_data) do
      {:ok, _} -> render(conn, %{access_key: access_key})
      _ -> render(conn, %{})
    end
  end

  def callback_soveriegn(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    # todo return OTP key on auth verification for opt in to sovereign
    access_key = generate_otp_key()
    user_data = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}

    with {:ok, _vault} <- DynamicVault.issue_vault(access_key),
         {:ok, _user} <- Sovereign.create_user(user_data) do
      render(conn, %{access_key: access_key})
    end
  end

  defp generate_otp_key do
    32 |> :crypto.strong_rand_bytes() |> Base.encode64()
  end
end
