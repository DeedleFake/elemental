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
      {Finch, name: Elemental.Finch},
      Elemental.Games,
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
