defmodule Thumber.Vault do
  use Cloak.Vault, otp_app: :my_app

  @impl GenServer
  def init(config) do
    config =
      Keyword.put(config, :ciphers,
        default: {
          Cloak.Ciphers.AES.GCM,
          tag: "AES.GCM.V1", key: decode_env!("CLOAK_KEY"), iv_length: 12
        }
      )

    {:ok, config}
  end

  defp decode_env!(_var) do
    32 |> :crypto.strong_rand_bytes()
  end

  # TODO: Do not lose decryption key
  # var
    # |> System.get_env()
    # |> Base.decode64!()
end
