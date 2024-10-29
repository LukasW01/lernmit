defmodule Lernmit.Repo.Migrations.CreateParticipant do
  use Ecto.Migration

  def change do
    create table(:participant) do
      add :course_id, references(:course, on_delete: :nothing)
      add :student_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:participant, [:course_id])
    create index(:participant, [:student_id])
  end
end
