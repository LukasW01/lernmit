defmodule Lernmit.Repo.Migrations.CreateAchievementUsers do
  use Ecto.Migration

  def change do
    create table(:achievement_users) do
      add :achievement_id, references(:achievement, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:achievement_users, [:achievement_id])
    create index(:achievement_users, [:user_id])
  end
end
