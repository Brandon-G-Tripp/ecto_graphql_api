defmodule GraphqlApiAssignment.ResolverHitGenServer do 
  use GenServer
  alias GraphqlApiAssignment.ResolverHitGenServer

  @default_name ResolverHitGenServer

  #API
  
  def start_link(opts \\ []) do 
    initial_state = %{
      "user" => 0,
      "users" => 0,
      "create_user" => 0,
      "update_user" => 0,
      "update_user_preference" => 0
    }
    opts = Keyword.put_new(opts, :name, @default_name)

    GenServer.start_link(ResolverHitGenServer, initial_state, opts)
  end

  def init(state) do 
    {:ok, state}
  end

  def add_hit(query_name, name \\ @default_name ) do 
    GenServer.cast(name, query_name)
  end

  def get_all_hits(key, name \\ @default_name) do 
    GenServer.call(name, key)
  end

  #Server

  def handle_cast(query_name, state) do 
    state = Map.update!(state, query_name, &(&1 + 1))

    {:noreply, state}
  end
  
  def handle_call(key, from_pid, state) do 
    return = %{key: key, query_hits: state[key]}

    {:reply, return, state}
  end


end
