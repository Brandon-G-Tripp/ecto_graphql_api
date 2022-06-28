defmodule GraphqlApiAssignment.Accounts.Preference do
  use Ecto.Schema
  import Ecto.Changeset

  schema "preferences" do
    field :likes_emails, :boolean, default: false
    field :likes_phone_calls, :boolean, default: false

    belongs_to :user, GraphqlApiAssignment.Accounts.User
  end

  @available_fields [:likes_phone_calls, :likes_emails]

  def create_changeset(params) do 
    changeset(%GraphqlApiAssignment.Accounts.Preference{}, params)
  end

  @doc false
  def changeset(preference, attrs) do
    preference
    |> cast(attrs, @available_fields)
    |> validate_required(@available_fields)
  end
end
