defmodule Lernmit.Repo.Migrations.CreateAchievement do
  use Ecto.Migration

  def change do
    create table(:achievement) do
      add :image, :string
      add :title, :string
      add :desc, :string

      timestamps(type: :utc_datetime)
    end
  end
end
