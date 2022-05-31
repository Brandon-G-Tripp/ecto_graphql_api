defmodule GraphqlApiAssignmentWeb.Schema.Mutations.User do 
  use Absinthe.Schema.Notation

  alias GraphqlApiAssignmentWeb.Resolvers

  object :user_mutations do 
    field :create_user, :user do 
      arg :name, non_null(:string)
      arg :email, non_null(:string)
      arg :preference, non_null(:user_preference_input)

      resolve &Resolvers.User.create_user/2
    end

    field :update_user, :user do 
      arg :id, non_null(:id)
      arg :name, :string
      arg :email, :string

      resolve &Resolvers.User.update_user/2
    end

    field :update_user_preference, :user_preference do
      arg :user_id, non_null(:id)
      arg :likes_emails, :boolean
      arg :likes_phone_calls, :boolean

      resolve &Resolvers.User.update_user_preference/2
    end
  end
end
