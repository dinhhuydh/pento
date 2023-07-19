defmodule Pento.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pento.Catalog` context.
  """

  @doc """
  Generate a unique product sku_integer.
  """
  def unique_product_sku_integer, do: "some sku_integer#{System.unique_integer([:positive])}"

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        sku_integer: unique_product_sku_integer(),
        unit_price: 120.5
      })
      |> Pento.Catalog.create_product()

    product
  end
end
