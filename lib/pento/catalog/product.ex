defmodule Pento.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :description, :string
    field :name, :string
    field :sku_integer, :string
    field :unit_price, :float

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku_integer])
    |> validate_required([:name, :description, :unit_price, :sku_integer])
    |> unique_constraint(:sku_integer)
  end
end
