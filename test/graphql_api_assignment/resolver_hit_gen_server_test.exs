defmodule GraphqlApiAssignment.ResolverHitGenServerTest do
  use ExUnit.Case, async: true

  alias GraphqlApiAssignment.ResolverHitGenServer

  setup do 
    {:ok, pid} = ResolverHitGenServer.start_link(name: nil)

    %{pid: pid}
  end

  describe "&add_hit/2" do 
    test "returns a no reply tuple when called with correct key", %{pid: pid} do 
      ResolverHitGenServer.add_hit("users", pid)  
      %{key: "users", query_hits: query_hits} = ResolverHitGenServer.get_all_hits("users", pid)
      assert query_hits === 1
    end
  end

  describe "&get_all_hits/2" do 
    test "returns 3 tuple {:reply, return, state} return value being a map with keys of key and query_hits", %{pid: pid} do 
      assert ResolverHitGenServer.get_all_hits("users", pid) === %{key: "users", query_hits: 0} 
    end
  end

end
