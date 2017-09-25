defmodule Escala.Factory do
  use ExMachina.Ecto, repo: Escala.Repo

  use Escala.AccountFactory
  use Escala.CMSFactory
end
