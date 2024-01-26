defmodule Log.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LogWeb.Telemetry,
      # Start the Ecto repository
      Log.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Log.PubSub},
      # Start Finch
      {Finch, name: Log.Finch},
      # Start the Endpoint (http/https)
      LogWeb.Endpoint
      # Start a worker by calling: Log.Worker.start_link(arg)
      # {Log.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Log.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LogWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
