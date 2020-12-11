defmodule BlockchainWeb.BlockController do
  use BlockchainWeb, :controller

  alias Blockchain.Blocks

  def index(conn, _params) do
    blocks = Blocks.list_blocks()

    conn
    |> put_status(:ok)
    |> render("index.json", blocks: blocks)
  end

  defp create_block(block, last_block) do
    {:ok, block} =
      block
      |> Map.put("previous_hash", last_block.hash)
      |> Map.put("index", last_block.index + 1)
      |> Map.put("timestamp", DateTime.utc_now())
      |> Blocks.create_block()

    block
  end

  defp create_block(block) do
    {:ok, block} =
      block
      |> Map.put("index", 0)
      |> Map.put("timestamp", DateTime.utc_now())
      |> Blocks.create_block()

    block
  end

  defp send_created_block(%Blocks.Block{} = block, conn) do
    conn
    |> put_status(:created)
    |> render("show.json", block: block)
  end

  defp send_created_block(_error, conn) do
    conn
    |> put_status(:bad_request)
  end

  def create(conn, %{"block" => block}) do
    case Blocks.get_last_block!() do
      {:ok, last_block} ->
        create_block(block, last_block)
        |> send_created_block(conn)

      {:error, _} ->
        create_block(block)
        |> send_created_block(conn)
    end
  end
end

# Blockchain.Blocks.create_block(%{data: %{}, index: 0, timestamp: DateTime.utc_now})
