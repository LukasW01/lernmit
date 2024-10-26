defmodule Lernmit.Repo.Migrations.CreateStudent do
  use Ecto.Migration

  def change do
    create table(:student) do
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:student, [:user_id])
  end
end
