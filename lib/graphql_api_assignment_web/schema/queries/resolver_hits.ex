defmodule GraphqlApiAssignmentWeb.Schema.Queries.ResolverHits do 
  use Absinthe.Schema.Notation

  alias GraphqlApiAssignmentWeb.Resolvers

  object :resolver_hit_queries do 
    field :resolver_hits, :resolver_hits do
      arg :key, :string

      resolve &Resolvers.ResolverHits.find/2
    end
  end
end
