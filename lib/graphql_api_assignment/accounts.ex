defmodule GraphqlApiAssignment.Accounts do
  alias GraphqlApiAssignment.Accounts.User
  alias GraphqlApiAssignment.Accounts.Preference
  alias GraphqlApiAssignment.ResolverHitGenServer
  alias GraphqlApiAssignment.Repo
  alias EctoShorts.Actions

  @available_preferences [:likes_emails, :likes_phone_calls]


  def all(params \\ %{}) do
    %{filters: filter_params, preference: preference_params} = reformat_params(params)

    ResolverHitGenServer.add_hit("users")


    User 
    |> User.user_by_preference
    |> User.where_preference(preference_params)
    |> Actions.all(filter_params)
  end

  defp reformat_params(params) do 
    params = Enum.reduce(params, %{preference: %{}, filters: %{}}, fn {key, val}, acc -> 
      if key in @available_preferences do 
        put_in(acc, [:preference, key], val)
      else
        put_in(acc, [:filters, key], val)
      end
    end)
    params = %{filters: Keyword.new(params.filters), preference: Keyword.new(params.preference)}
  end
  
  def find(params) do
    ResolverHitGenServer.add_hit("user")

    Actions.find(User, params)
  end

  def create_user(params) do
    ResolverHitGenServer.add_hit("create_user")

    Actions.create(User, params)
  end

  def update_user(id, params) do 
   ResolverHitGenServer.add_hit("update_user")

    Actions.update(User, id, params)
  end

  def update_user_preference(id, params) do 
    ResolverHitGenServer.add_hit("update_user_preference")

    Actions.update(Preference, id, params)
  end
end
