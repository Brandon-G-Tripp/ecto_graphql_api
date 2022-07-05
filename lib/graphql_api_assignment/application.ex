defmodule GraphqlApiAssignment.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      GraphqlApiAssignment.Repo,
      # Start the Telemetry supervisor
      GraphqlApiAssignmentWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: GraphqlApiAssignment.PubSub},
      # Start the Endpoint (http/https)
      GraphqlApiAssignmentWeb.Endpoint,
      {Absinthe.Subscription, GraphqlApiAssignmentWeb.Endpoint},
      # Start a worker by calling: GraphqlApiAssignment.Worker.start_link(arg)
      # {GraphqlApiAssignment.Worker, arg}
      GraphqlApiAssignment.ResolverHits
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GraphqlApiAssignment.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GraphqlApiAssignmentWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
