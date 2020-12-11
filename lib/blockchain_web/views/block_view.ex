defmodule BlockchainWeb.BlockView do
  use BlockchainWeb, :view

  alias BlockchainWeb.BlockView

  def render("index.json", %{blocks: blocks}) do
    %{data: render_many(blocks, BlockView, "block.json")}
  end

  def render("show.json", %{block: block}) do
    %{data: render_one(block, BlockView, "block.json")}
  end

  def render("block.json", %{block: block}) do
    %{
      id: block.id,
      index: block.index,
      data: block.data,
      hash: block.hash,
      previous_hash: block.previous_hash,
      timestamp: block.timestamp
    }
  end
end
