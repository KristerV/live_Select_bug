defmodule LiveSelectBug.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :first_name, :string
      add :last_name, :string
      add :country, :string

      timestamps()
    end
  end
end
