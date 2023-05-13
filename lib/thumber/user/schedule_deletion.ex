defmodule Thumber.User.ScheduleDeletion do
  @moduledoc """
    Periodically purge user data.
  """
  use GenServer
  alias Thumber.{Repo, User}

  def start_link(_) do
      GenServer.start_link(__MODULE__, nil)
  end

  @impl true
  def init(_) do
    Process.send_after(self(), :purge_users, :timer.hours(12))
    {:ok, nil}
  end

  @impl true
  def handle_info(:purge, state) do
    purge()
    Process.send_after(self(), :purge, :timer.hours(12))
    {:noreply, state}
  end

  def purge do
    import Ecto.Query, only: [from: 2]

    Repo.delete_all(from(u in User, where: u.schedule_delete))
  end
end
