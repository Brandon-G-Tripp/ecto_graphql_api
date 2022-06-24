defmodule GraphqlApiAssignmentWeb.Schema.Subscriptions.User do 
  use Absinthe.Schema.Notation

  object :user_subscriptions do
    field :created_user, :user do
      trigger :create_user, topic: fn _ -> 
        "new_user"
      end

      config fn _, _ -> 
        {:ok, topic: "new_user"}
      end
    end

    field :updated_user_preference, :user_preference do
      arg :user_id, non_null(:id)

      trigger :update_user_preference, topic: fn preference -> 
        "user_preference_update:#{preference.user_id}"
      end

      config fn args, _ ->
        {:ok, topic: "user_preference_update:#{args.user_id}"}
      end

    end
  end
end
