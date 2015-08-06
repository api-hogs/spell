defmodule Spell.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :text
      add :read, :boolean, default: false
      add :receiver_id, references(:users)
      add :sender_id, references(:users)

      timestamps
    end
    create index(:messages, [:receiver_id])
    create index(:messages, [:sender_id])

  end
end
