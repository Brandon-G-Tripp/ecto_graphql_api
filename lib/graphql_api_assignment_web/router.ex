defmodule GraphqlApiAssignmentWeb.Router do
  use GraphqlApiAssignmentWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphql",
      Absinthe.Plug,
      schema: GraphqlApiAssignmentWeb.Schema

    forward "/graphiql", 
      Absinthe.Plug.GraphiQL,
      schema: GraphqlApiAssignmentWeb.Schema,
      socket: GraphqlApiAssignmentWeb.UserSocket,
      interface: :playground
  end

end
