defmodule RestaurantAppPlatformWeb.RestaurantJSON do
  alias RestaurantAppPlatform.Restaurants.Restaurant

  @doc """
  Renders a list of restaurants.
  """
  def index(%{restaurants: restaurants}) do
    %{data: for(restaurant <- restaurants, do: data(restaurant))}
  end

  @doc """
  Renders a single restaurant.
  """
  def show(%{restaurant: restaurant}) do
    %{data: data(restaurant)}
  end

  defp data(%Restaurant{} = restaurant) do
    %{
      id: restaurant.id,
      name: restaurant.name,
      location: restaurant.location,
      contact_number: restaurant.contact_number
    }
  end
end
