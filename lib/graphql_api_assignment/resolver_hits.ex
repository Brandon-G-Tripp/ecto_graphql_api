defmodule GraphqlApiAssignment.ResolverHits do 
  alias GraphqlApiAssignment.ResolverHitGenServer

  def find(key) do 
    value = ResolverHitGenServer.get_all_hits(key) 
      
    {:ok, value}
  end
end
