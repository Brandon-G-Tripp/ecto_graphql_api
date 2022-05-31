defmodule GraphqlApiAssignment.Repo.Migrations.UserCreateIndexOnPreferences do
  use Ecto.Migration

  def change do
    alter table(:users) do 
      add :preference, references(:preferences, on_delete: :delete_all)
    end
    
    create index(:users, [:preference]) end
end
