defmodule Blockchain.Repo.Migrations.CreateBlocks do
  use Ecto.Migration

  def change do
    create table(:blocks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :index, :integer
      add :previous_hash, :string
      add :hash, :string
      add :data, :map
      add :timestamp, :utc_datetime
    end

    create unique_index(:blocks, [:index, :hash, :previous_hash])
  end
end
