defmodule RestaurantAppPlatform.Menus do
  import Ecto.Query, warn: false
  alias RestaurantAppPlatform.Repo
  alias RestaurantAppPlatform.Menus.Menu

  @doc """
  Get all menus for a restaurant grouped by category.
  """
  def get_menus_by_restaurant_id(restaurant_id) do
    query = from(m in Menu,
      where: m.restaurant_id == ^restaurant_id,
      preload: [:category]
    )

    menus = Repo.all(query)
    IO.inspect(menus, label: "Fetched Menus for Restaurant")  # Debugging fetched menus

    # Group the menus by category name
    menus
    |> Enum.group_by(fn menu -> menu.category && menu.category.name || "No Category" end)
  end

  @doc """
  Create a batch of menus.
  """
  # def create_menus(menus_params) do
  #   Enum.map(menus_params, fn params ->
  #     create_menu(params)
  #   end)
  # end

  def create_menus(menus_params) do
  Enum.map(menus_params, &create_menu/1)
end


  @doc """
  Create a menu.
  """
  def create_menu(attrs \\ %{}) do
    %Menu{}
    |> Menu.changeset(attrs)
    |> Repo.insert()
  end
end
