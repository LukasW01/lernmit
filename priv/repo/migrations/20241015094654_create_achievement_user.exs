defmodule Lernmit.Repo.Migrations.CreateAchievementUser do
  use Ecto.Migration

  def change do
    create table(:achievement_user) do
      add :achievement_id, references(:achievements, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:achievement_user, [:achievement_id])
    create index(:achievement_user, [:user_id])
  end
end
