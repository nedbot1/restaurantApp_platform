defmodule RestaurantAppPlatform.Menus do
  @moduledoc """
  The Menus context.
  """

  import Ecto.Query, warn: false
  alias RestaurantAppPlatform.Repo

  alias RestaurantAppPlatform.Menus.Menu

  @doc """
  Returns the list of menus.

  ## Examples

      iex> list_menus()
      [%Menu{}, ...]

  """
  def list_menus do
    Repo.all(Menu)
  end

  @doc """
  Gets a single menu.

  Raises `Ecto.NoResultsError` if the Menu does not exist.

  ## Examples

      iex> get_menu!(123)
      %Menu{}

      iex> get_menu!(456)
      ** (Ecto.NoResultsError)

  """
  def get_menu!(id), do: Repo.get!(Menu, id)

 def get_menus_by_restaurant_id(restaurant_id) do
  query = from(m in Menu, where: m.restaurant_id == ^restaurant_id)
     Repo.all(query)
  end

  @doc """
  Creates a menu.

  ## Examples

      iex> create_menu(%{field: value})
      {:ok, %Menu{}}

      iex> create_menu(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_menu(attrs \\ %{}) do
    %Menu{}
    |> Menu.changeset(attrs)
    |> Repo.insert()
  end


  def create_menus(menus_params) do
    Enum.map(menus_params, fn params ->
      create_menu(params)
    end)
  end

  @doc """
  Updates a menu.

  ## Examples

      iex> update_menu(menu, %{field: new_value})
      {:ok, %Menu{}}

      iex> update_menu(menu, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_menu(%Menu{} = menu, attrs) do
    menu
    |> Menu.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a menu.

  ## Examples

      iex> delete_menu(menu)
      {:ok, %Menu{}}

      iex> delete_menu(menu)
      {:error, %Ecto.Changeset{}}

  """
  def delete_menu(%Menu{} = menu) do
    Repo.delete(menu)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking menu changes.

  ## Examples

      iex> change_menu(menu)
      %Ecto.Changeset{data: %Menu{}}

  """
  def change_menu(%Menu{} = menu, attrs \\ %{}) do
    Menu.changeset(menu, attrs)
  end
end
