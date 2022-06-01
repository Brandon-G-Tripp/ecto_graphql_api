defmodule GraphqlApiAssignmentWeb.Accounts do
  alias GraphqlApiAssignment.Accounts.User
  alias GraphqlApiAssignment.Accounts.Preference
  alias GraphqlApiAssignment.Repo
  alias EctoShorts.Actions

  import Ecto.Query

  def all(params \\ %{}) do
    %{filters: filter_params, preference: preference_params}= do_all_build_params(params)

    filter_params = Keyword.new(filter_params)
    preference_params = Keyword.new(preference_params)
    
    User 
    |> join(:inner, [u], p in assoc(u, :preference), as: :preference)
    |> where_preference(preference_params)
    |> Actions.all(filter_params)
  end

  defp where_preference(query, preference) do 
    Enum.reduce(preference, query, fn {key, val}, acc -> 
      where(acc, [preference: p], field(p, ^key) == ^val)
    end)
  end

  defp do_all_build_params(params) do 
    params = Enum.reduce(params, %{preference: %{}, filters: %{}}, fn filter, acc -> 
      {key, value} = filter
      regex = ~r/likes_[a-z_]/
      cond do 
        String.match?(Atom.to_string(key), regex) -> 
          acc = put_in(acc[:preference][key], value)
        true -> 
          acc = put_in(acc[:filters][key], value)
      end
    end)
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
    Actions.update(Preference, id, params)
  end
end
