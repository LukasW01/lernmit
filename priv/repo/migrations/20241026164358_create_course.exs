defmodule Lernmit.Repo.Migrations.CreateCourse do
  use Ecto.Migration

  def change do
    create table(:course) do
      add :student_id, references(:student, on_delete: :nothing)
      add :teacher_id, references(:teacher, on_delete: :nothing)
      add :class_id, references(:class, on_delete: :nothing)
      add :subject_id, references(:subject, on_delete: :nothing)
      add :task_id, references(:task, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:course, [:student_id])
    create index(:course, [:teacher_id])
    create index(:course, [:class_id])
    create index(:course, [:subject_id])
    create index(:course, [:task_id])
  end
end
