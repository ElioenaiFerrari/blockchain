defmodule Blockchain.Blocks.Block do
  use Ecto.Schema
  import Bcrypt
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "blocks" do
    field :data, :map
    field :index, :integer
    field :hash, :string
    field :previous_hash, :string
    field :timestamp, :utc_datetime
  end

  @doc false
  def changeset(block, attrs) do
    block
    |> cast(attrs, [:index, :previous_hash, :timestamp, :hash, :data])
    |> validate_required([:index, :timestamp, :data])
    |> create_hash()
  end

  defp create_hash(
         %Ecto.Changeset{
           valid?: true,
           changes: %{
             index: index,
             data: data,
             timestamp: timestamp
           }
         } = changeset
       ) do
    change(
      changeset,
      hash: hash_pwd_salt("#{Jason.encode!(data)}#{index}#{timestamp}")
    )
  end

  defp create_hash(changeset), do: changeset
end
