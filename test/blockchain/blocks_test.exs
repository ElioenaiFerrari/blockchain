defmodule Blockchain.BlocksTest do
  use Blockchain.DataCase

  alias Blockchain.Blocks

  def create_genesis_block() do
    %{data: %{genesis: true}, index: 0, timestamp: DateTime.utc_now()}
    |> Blocks.create_block()
  end

  describe "blocks" do
    test "create first block" do
      case create_genesis_block() do
        {:ok, genesis_block} ->
          refute is_nil(genesis_block.hash)

        {:error, _} ->
          assert false
      end
    end

    test "create two blocks" do
      case create_genesis_block() do
        {:ok, genesis_block} ->
          with {:ok, block} <-
                 Blocks.create_block(%{
                   data: %{genesis: true},
                   index: 0,
                   timestamp: DateTime.utc_now(),
                   previous_hash: genesis_block.hash
                 }) do
            %{genesis: genesis_block, second: block}
            |> IO.inspect()

            assert block.previous_hash == genesis_block.hash
          end

        {:error, _} ->
          assert false
      end
    end
  end
end
