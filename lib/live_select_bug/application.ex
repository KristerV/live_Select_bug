defmodule LiveSelectBug.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LiveSelectBugWeb.Telemetry,
      # Start the Ecto repository
      LiveSelectBug.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveSelectBug.PubSub},
      # Start Finch
      {Finch, name: LiveSelectBug.Finch},
      # Start the Endpoint (http/https)
      LiveSelectBugWeb.Endpoint
      # Start a worker by calling: LiveSelectBug.Worker.start_link(arg)
      # {LiveSelectBug.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveSelectBug.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveSelectBugWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
