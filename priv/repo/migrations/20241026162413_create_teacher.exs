defmodule Lernmit.Repo.Migrations.CreateTeacher do
  use Ecto.Migration

  def change do
    create table(:teacher) do
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:teacher, [:user_id])
  end
end
