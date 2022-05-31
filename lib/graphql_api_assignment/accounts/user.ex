defmodule GraphqlApiAssignment.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string

    has_one(:preference, GraphqlApiAssignment.Accounts.Preference, on_replace: :update)

    timestamps()
  end

  @available_fields [:name, :email]

  def create_changeset(params) do 
    changeset(%GraphqlApiAssignment.Accounts.User{}, params)
  end

  @doc false
  def changeset(user = %GraphqlApiAssignment.Accounts.User{}, attrs) do
    user
    |> EctoShorts.CommonChanges.preload_changeset_assoc(:preference)
    |> cast(attrs, @available_fields)
    |> validate_required(@available_fields)
    |> cast_assoc(:preference)
  end
end
