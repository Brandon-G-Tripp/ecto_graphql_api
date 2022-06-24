defmodule GraphqlApiAssignmentWeb.SubscriptionCase do 
  use ExUnit.CaseTemplate

  using do 
    quote do 
      use GraphqlApiAssignmentWeb.ChannelCase

      use Absinthe.Phoenix.SubscriptionTest,
        schema: GraphqlApiAssignmentWeb.Schema

      setup do 
        {:ok, socket} = Phoenix.ChannelTest.connect(GraphqlApiAssignmentWeb.UserSocket, %{})
        {:ok, socket} = Absinthe.Phoenix.SubscriptionTest.join_absinthe(socket)

        {:ok, %{socket: socket}}
      end
    end
  end
end
