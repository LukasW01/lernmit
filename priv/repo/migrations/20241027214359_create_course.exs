defmodule Lernmit.Repo.Migrations.CreateCourse do
  use Ecto.Migration

  def change do
    create table(:course) do
      add :class, :string
      add :subject, :string
      add :teacher_id, references(:users, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:course, [:teacher_id])
  end
end
