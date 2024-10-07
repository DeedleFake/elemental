defmodule Elemental.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ElementalWeb.Telemetry,
      Elemental.Repo,
      {DNSCluster, query: Application.get_env(:elemental, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Elemental.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Elemental.Finch},
      # Start a worker by calling: Elemental.Worker.start_link(arg)
      # {Elemental.Worker, arg},
      # Start to serve requests, typically the last entry
      ElementalWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Elemental.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ElementalWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
