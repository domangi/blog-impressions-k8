defmodule Consumer do
  require Logger

  def handle_messages(messages) do
    for %{key: _, value: urn} <- messages do
      Logger.info("Received message: #{urn}")
      {status, value} = Redix.command(:redix, ["INCR", urn])
      Logger.info("-> Redis Response: #{status}/#{value}")
    end

    :ok
  end
end
