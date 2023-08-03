defmodule GraphqlApiAssignment.Accounts do
  alias GraphqlApiAssignment.Accounts.{User, Preference}
  alias EctoShorts.Actions

  @available_preferences [:likes_emails, :likes_phone_calls]


  def all(params \\ %{}) do
    %{filters: filter_params, preference: preference_params} = reformat_params(params)

    User 
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
    %{filters: Keyword.new(params.filters), preference: Keyword.new(params.preference)}
  end
  
  def find(params) do
    Actions.find(User, params)
  end

  def create_user(params) do
    Actions.create(User, params)
  end

  def update_user(id, params) do 
    Actions.update(User, id, params)
  end

  def update_user_preference(id, params) do 
    with {:ok, preference} <-  Actions.find(Preference, %{user_id: id}) do
      Actions.update(Preference, preference, params)
    end
  end
end
