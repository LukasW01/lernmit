defmodule Lernmit.Repo.Migrations.AddUserRole do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :role, :string
      add :locale, :string
      add :name, :string
    end
  end
end
