defmodule GraphqlApiAssignmentWeb.Resolvers.ResolverHits do 
  alias GraphqlApiAssignment.ResolverHits

  def find(%{key: key}, _) do 
    IO.inspect(key, label: "key")
    ResolverHits.find(key)
    |> IO.inspect(label: "return of resolver") 
  end
end
