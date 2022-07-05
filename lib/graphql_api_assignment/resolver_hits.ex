defmodule GraphqlApiAssignment.ResolverHits do 
  use Agent
  alias GraphqlApiAssignment.ResolverHits

  @default_name ResolverHits

  #API
  
  def start_link(opts \\ []) do 
    opts = Keyword.put_new(opts, :name, @default_name)

    Agent.start_link(fn -> %{} end, opts)
  end

  def add_hit(query_name, name \\ @default_name ) do 
    Agent.update(name, fn state -> 
      Map.update(state,query_name, 1, &(&1 + 1))
    end)
  end

  def get(key, name \\ @default_name) do 
    Agent.get(name, fn state -> 
      val = Map.get(state, key, 0)
      %{key: key, query_hits: val}
    end)
  end

  def find(key) do 
    value = ResolverHits.get(key) 
      
    {:ok, value}
  end
end
