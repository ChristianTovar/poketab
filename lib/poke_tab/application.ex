defmodule PokeTab.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PokeTabWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:poke_tab, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PokeTab.PubSub},
      # Start a worker by calling: PokeTab.Worker.start_link(arg)
      # {PokeTab.Worker, arg},
      # Start to serve requests, typically the last entry
      PokeTabWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PokeTab.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PokeTabWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
