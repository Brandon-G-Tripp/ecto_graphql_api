defmodule GraphqlApiAssignmentWeb.Schema do
  use Absinthe.Schema

  import_types GraphqlApiAssignmentWeb.Types.User
  import_types GraphqlApiAssignmentWeb.Types.ResolverHits

  import_types GraphqlApiAssignmentWeb.Schema.Queries.User
  import_types GraphqlApiAssignmentWeb.Schema.Queries.ResolverHits
  import_types GraphqlApiAssignmentWeb.Schema.Mutations.User
  import_types GraphqlApiAssignmentWeb.Schema.Subscriptions.User

  query do
    import_fields :user_queries
    import_fields :resolver_hit_queries
  end

  mutation do 
    import_fields :user_mutations
  end

  subscription do
    import_fields :user_subscriptions
  end

  def context(ctx) do 
    source = Dataloader.Ecto.new(GraphqlApiAssignment.Repo)
    dataloader = Dataloader.add_source(Dataloader.new(), GraphqlApiAssignment.Accounts.Preferences, source)

    Map.put(ctx, :loader, dataloader)
  end

  def plugins do 
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

end
