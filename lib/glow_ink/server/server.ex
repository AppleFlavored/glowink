defmodule GlowInk.Server do
  use GenServer
  require Logger

  def start_link(state \\ %{}) do
    # See: application.ex L7
    port = Map.get(state, :port, 25565)
    Logger.info("Starting server on port: #{port}")
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    port = Map.get(state, :port, 25565)
    {:ok, socket} = :gen_tcp.listen(port, [:binary, active: false])
    handle_incoming(socket)
  end

  def handle_incoming(socket) do
    {:ok, client} = :gen_tcp.accept(socket)

    Logger.info("Received client connection.")
    :gen_tcp.close(client)
    Logger.info("Closed client connection.")

    handle_incoming(socket)
  end

  def handle_info({:tcp, _, data}, state) do
    Logger.info("Received #{data}")

    {:noreply, state}
  end
end
