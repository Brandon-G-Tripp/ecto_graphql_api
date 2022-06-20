defmodule GraphqlApiAssignmentWeb.Resolvers.User do
  alias GraphqlApiAssignment.Accounts

  def find(%{id: id}, _) do
    id = String.to_integer(id)
    Accounts.find(%{id: id})
  end

  def all(params, _) do
    users = Accounts.all(params)
    {:ok, users}
  end

  def create_user(params, _) do
    Accounts.create_user(params)
  end

  def update_user(%{id: id} = params, _) do
    id = String.to_integer(id)
    Accounts.update_user(id, Map.delete(params, :id))
  end

  def update_user_preference(%{user_id: id} = params, _) do
    id = String.to_integer(id)
    Accounts.update_user_preference(id, Map.delete(params, :user_id))
  end

end
