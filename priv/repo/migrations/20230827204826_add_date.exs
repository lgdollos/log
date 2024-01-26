defmodule Log.Repo.Migrations.AddDate do
  use Ecto.Migration

  def change do
    alter table(:logs) do
      add :year, :integer
      add :month, :integer
      add :day, :integer
      add :hour, :integer
    end
  end
end
