defmodule GraphqlApiAssignmentWeb.Types.User do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 2]

  import_types GraphqlApiAssignmentWeb.Types.UserPreferences

  @desc "A user that has preferences"
  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
    field :preference, :user_preference, resolve: dataloader(GraphqlApiAssignment.Accounts.Preferences, :preference)
  end

  @desc "User preference for input"
  input_object :user_preference_input do
    field :likes_emails, :boolean
    field :likes_phone_calls, :boolean
  end

end
