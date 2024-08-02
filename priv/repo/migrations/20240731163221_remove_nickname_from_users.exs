defmodule SimpleChat.Repo.Migrations.RemoveNicknameFromUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :nickname
    end
  end
end
