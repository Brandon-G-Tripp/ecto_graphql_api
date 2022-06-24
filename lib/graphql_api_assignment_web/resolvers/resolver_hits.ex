defmodule GraphqlApiAssignmentWeb.Resolvers.ResolverHits do 
  alias GraphqlApiAssignment.ResolverHits

  def find(%{key: key}, _) do 
    ResolverHits.find(key)
  end
end
