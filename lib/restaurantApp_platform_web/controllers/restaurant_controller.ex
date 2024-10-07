defmodule RestaurantAppPlatformWeb.RestaurantController do
  use RestaurantAppPlatformWeb, :controller

  alias RestaurantAppPlatform.Restaurants
  alias RestaurantAppPlatform.Restaurants.Restaurant

  action_fallback RestaurantAppPlatformWeb.FallbackController

  def index(conn, _params) do
    restaurants = Restaurants.list_restaurants()
    render(conn, :index, restaurants: restaurants)
  end

  def create(conn, %{"restaurant" => restaurant_params}) do
    with {:ok, %Restaurant{} = restaurant} <- Restaurants.create_restaurant(restaurant_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/restaurants/#{restaurant}")
      |> render(:show, restaurant: restaurant)
    end
  end

  def show(conn, %{"id" => id}) do
    restaurant = Restaurants.get_restaurant!(id)
    render(conn, :show, restaurant: restaurant)
  end

  def show_by_account(conn, %{"account_id" => account_id}) do
    case Restaurants.get_restaurant_by_account_id(account_id)do
      nil ->
        conn
          |> put_status(:not_found)
          |> json(%{error: "Restaurant not found"})

      restaurant ->
        conn
          |>json(restaurant)
    end
  end

  def update(conn, %{"id" => id, "restaurant" => restaurant_params}) do
    restaurant = Restaurants.get_restaurant!(id)

    with {:ok, %Restaurant{} = restaurant} <- Restaurants.update_restaurant(restaurant, restaurant_params) do
      render(conn, :show, restaurant: restaurant)
    end
  end

  def delete(conn, %{"id" => id}) do
    restaurant = Restaurants.get_restaurant!(id)

    with {:ok, %Restaurant{}} <- Restaurants.delete_restaurant(restaurant) do
      send_resp(conn, :no_content, "")
    end
  end
end
