defmodule GraphqlApiAssignmentWeb.Types.ResolverHits do 
  use Absinthe.Schema.Notation

  @desc "A resolver key"
  object :resolver_hits do 
    field :key, :string
    field :query_hits, :integer
  end

end
