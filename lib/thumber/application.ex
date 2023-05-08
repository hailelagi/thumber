defmodule Thumber.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ThumberWeb.Telemetry,
      Thumber.Repo,
      {Phoenix.PubSub, name: Thumber.PubSub},
      ThumberWeb.Endpoint,
      Thumber.Vault
    ]

    opts = [strategy: :one_for_one, name: Thumber.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    ThumberWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
