defmodule Lernmit.Repo.Migrations.CreateTask do
  use Ecto.Migration

  def change do
    create table(:task) do
      add :title, :string
      add :text, :string
      add :status, :string
      add :types, :string
      add :due_date, :naive_datetime
      add :points, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:task, [:user_id])
  end
end
