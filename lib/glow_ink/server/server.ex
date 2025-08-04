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

  defp handle_incoming(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    serve(client)
    handle_incoming(socket)
  end

  defp serve(client) do
    client
    |> read_packet()
    |> handle_packet(client)

    :gen_tcp.close(client)
  end

  defp read_packet(client) do
    {:ok, data} = :gen_tcp.recv(client, 0)
    data
  end

  defp handle_packet(data, _client) do

  end

  defp read_varint(data) do

  end
end
