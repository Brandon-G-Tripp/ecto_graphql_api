defmodule GraphqlApiAssignment.Repo.Migrations.MakeEmailsUniqueFieldOnUser do
  use Ecto.Migration

  def change do
    unique_index(:users, [:email])
  end
end
