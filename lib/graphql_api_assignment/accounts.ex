defmodule GraphqlApiAssignmentWeb.Accounts do
  alias GraphqlApiAssignment.Accounts.User
  alias GraphqlApiAssignment.Accounts.Preference
  alias EctoShorts.Actions

  def all(params \\ %{}) do
    params = do_all_build_params(params)
    Actions.all(User, params)
  end

  defp do_all_build_params(params) do 
    params = Enum.reduce(params, %{preference: %{}}, fn filter, acc -> 
      {key, value} = filter
      regex = ~r/likes_[a-z_]/
      cond do 
        String.match?(Atom.to_string(key), regex) -> 
          acc = put_in(acc[:preference][key], value)
        true -> 
          acc = put_in(acc[key], value)
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
