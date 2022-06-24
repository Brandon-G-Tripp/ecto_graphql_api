defmodule GraphqlApiAssignmentWeb.Types.UserPreferences do 
  use Absinthe.Schema.Notation

  @desc "Preferences for user"
  object :user_preference do
    field :likes_emails, :boolean
    field :likes_phone_calls, :boolean
    field :user_id, :id
  end

end
