defmodule GraphqlApiAssignment.ResolverHitsTest do
  use ExUnit.Case, async: true

  alias GraphqlApiAssignment.ResolverHits

  setup do 
    {:ok, pid} = ResolverHits.start_link(name: nil)

    %{pid: pid}
  end

  describe "&add_hit/2" do 
    test "returns a no reply tuple when called with correct key", %{pid: pid} do 
      ResolverHits.add_hit("users", pid)  
      %{key: "users", query_hits: query_hits} = ResolverHits.get("users", pid)
      assert query_hits === 1
    end
  end

  describe "&get_all_hits/2" do 
    test "returns 3 tuple {:reply, return, state} return value being a map with keys of key and query_hits", %{pid: pid} do 
      assert ResolverHits.get("users", pid) === %{key: "users", query_hits: 0} 
    end
  end

end
