defmodule GraphqlApiAssignment.ResolverHits do 
  alias GraphqlApiAssignment.ResolverHitGenServer

  def find(key) do 
    IO.inspect(key, label: "key")
    value = ResolverHitGenServer.get_all_hits(key) 
      
    {:ok, value}
  end
end
