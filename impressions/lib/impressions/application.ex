defmodule Impressions.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Impressions.RestApi,
        options: [port: 4000]
      ),
      {
        Redix,
        name: :redix,
        host: System.get_env("REDIS_HOST", "localhost"),
        port: System.get_env("REDIS_PORT", "6379") |> String.to_integer()
      },
      kaffe_consumer()
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Impressions.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp kaffe_consumer do
    %{
      id: Kaffe.GroupMemberSupervisor,
      start: {Kaffe.GroupMemberSupervisor, :start_link, []},
      type: :worker
    }
  end
end
