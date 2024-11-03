defmodule Lernmit.Repo.Migrations.CreateTask do
  use Ecto.Migration

  def change do
    create table(:task) do
      add :title, :string
      add :text, :text
      add :status, :string
      add :types, :string
      add :due_date, :naive_datetime
      add :points, :integer
      add :course_id, references(:course, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end
  end
end
