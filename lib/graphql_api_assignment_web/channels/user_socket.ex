defmodule GraphqlApiAssignmentWeb.UserSocket do
  use Phoenix.Socket
  use Absinthe.Phoenix.Socket, schema: GraphqlApiAssignmentWeb.Schema

  channel "users", GraphqlApiAssignmentWeb.UserChannel

  @impl true
  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  @impl true
  def id(_socket), do: nil
end
