defmodule Impressions.RestApi do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  get "/impressions/:urn" do
    {status, count} =
      case impressions_count(urn) do
        {:ok, value} -> {200, value}
        {:error, _} -> {200, 0}
      end

    send_resp(conn, status, Poison.encode!(%{urn: urn, count: count}))
  end

  match _ do
    send_resp(
      conn,
      404,
      "oops... Nothing here :("
    )
  end

  defp impressions_count(urn) do
    case Redix.command(:redix, ["GET", urn]) do
      {:ok, nil} ->
        {:ok, 0}

      {:ok, value} ->
        {count, _} = Integer.parse(value)
        {:ok, count}

      {:error, _} ->
        {:error, 0}
    end
  end
end
