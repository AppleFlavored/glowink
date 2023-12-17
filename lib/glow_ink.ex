defmodule GlowInk.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {GlowInk.Server, %{port: 25565}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    opts = [strategy: :one_for_one, name: GlowInk.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
