defmodule GraphqlApiAssignment.Repo.Migrations.PreferencesAddIndexOnUser do
  use Ecto.Migration

  def change do
    create index(:preferences, [:user_id])
  end
end
