defmodule GraphqlApiAssignment.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "users" do
    field :email, :string
    field :name, :string

    has_one :preference, GraphqlApiAssignment.Accounts.Preference, on_replace: :update

    timestamps()
  end

  def user_by_preference(query \\ User) do 
    join(query, :inner, [u], p in assoc(u, :preference), as: :preference)
  end

  def where_preference(query \\ User, preference) do 
    Enum.reduce(preference, query, fn {key, val}, acc -> 
      where(acc, [preference: p], field(p, ^key) == ^val)
    end)
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
