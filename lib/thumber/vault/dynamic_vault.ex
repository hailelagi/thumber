defmodule Thumber.DynamicVault do
  use Cloak.Vault, otp_app: :thumber

  def issue_vault(key) do
    DynamicSupervisor.start_child(
      Thumber.VaultSupervisor,
      {Thumber.DynamicVault, name: vault_name(), key: key}
    )
  end

  def start_link(config \\ []) do
    app_config = Application.get_env(@otp_app, __MODULE__, [])
    config = Keyword.merge(app_config, config)
    vault_name = Keyword.get(config, :name)

    {:ok, pid} =
      GenServer.start_link(__MODULE__, config,
        name: {:via, Registry, {Thumber.VaultRegistry, vault_name}}
      )

    GenServer.call(pid, :save_config, 10_000)
    {:ok, pid}
  end

  # TODO: Must Overite the ets mechanism to use store vault names
  # Either Using a fork or override the macro definitions whichever happens to be easier
  # currently after a new vault is created it overrides the previously stored config.
  # this behaviour is not ideal.
  def save_config(table_name, config) do
    if :ets.info(table_name) == :undefined do
      :ets.new(table_name, [:named_table, :public])
    end

    :ets.insert(table_name, {:config, config})
  end

  def read_config(table_name) do
    case :ets.lookup(table_name, :config) do
      [{:config, config} | _] ->
        config

      _ ->
        :error
    end
  end

  @impl GenServer
  def init(config) do
    case validate_key(config) do
      {:ok, key} -> make_config(config, key)
      :error -> {:stop, {:error, "invalid key"}}
    end
  end

  defp validate_key(config) do
    config
    |> Keyword.get(:key)
    |> Base.decode64()
  end

  defp make_config(config, key) do
    Keyword.put(config, :ciphers,
      default: {
        Cloak.Ciphers.AES.GCM,
        tag: "AES.GCM.V1", key: key, iv_length: 12
      }
    )

    {:ok, config}
  end

  defp vault_name, do: Ecto.UUID.generate()
end
