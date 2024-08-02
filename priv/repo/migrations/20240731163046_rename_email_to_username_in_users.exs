defmodule SimpleChat.Repo.Migrations.RenameUsernameToUsernameInUsers do
  use Ecto.Migration

  def change do
    rename table(:users), :username, to: :username
  end
end
