defmodule Thumber.Encrypted.DynamicBinary do
  use Cloak.Ecto.Binary, vault: Thumber.DynamicVault
end
