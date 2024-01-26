defmodule Log.Repo.Migrations.CreateLog do
  use Ecto.Migration

  def change do
    create table(:logs) do
      add :log, :string
      timestamps()
    end
  end
end
