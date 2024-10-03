# priv/repo/seeds.exs

alias RestaurantAppPlatform.Repo
alias RestaurantAppPlatform.Accounts.Account
alias RestaurantAppPlatform.Restaurants.Restaurant
alias RestaurantAppPlatform.Menus.Menu
alias RestaurantAppPlatform.Tables.Table

# create users
accounts = [
  %Account{
    owner_name: "tobdhen",
    email: "tobdhen@app.com",
    password_hash: "1234",
    subscribed_at: ~U[2024-09-01T12:00:00Z],
    phone_number: "17661088"
  },
  %Account{
    owner_name: "sherab",
    email: "sherab@app.com",
    password_hash: "1234",
    subscribed_at: ~U[2024-09-01T12:00:00Z],
    phone_number: "77223344"
  }
]

# Insert data into the database
Enum.each(accounts, fn account ->
  account = Repo.insert!(account)

  # create restaurants
  restaurants = [
    %Restaurant{
      name: "Tob-Dhen",
      location: "Cairo",
      contact_number: "123456789",
      account_id: account.id
    },
    %Restaurant{
      name: "Sherab",
      location: "Alexandria",
      contact_number: "123456789",
      account_id: account.id
    }
  ]

  Enum.each(restaurants, fn restaurant ->
    restaurant = Repo.insert!(restaurant)

    # create menus
    menus = [
      %Menu{
        item_name: "pork-ribs",
        item_description: "Juicy hot and tender pork meat and ribs",
        price: 220,
        dish_photo_link:
          "https://www.southernliving.com/thmb/J02EQeOhOKHfmALt-jE_61idUck=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/oven-baked-baby-back-ribs-beauty-332-7deda00b7b4f4820a9c79f13ed09cfb9.jpg",
        restaurant_id: restaurant.id
      },
      %Menu{
        item_name: "beef jerky",
        item_description: "Juicy hot and tender meat and ribs",
        price: 100,
        dish_photo_link:
          "https://img.freepik.com/free-photo/raw-meats-with-spices-utensils-rustic-cutting-board-dark-wood-top-view-ai-generative_123827-23528.jpg",
        restaurant_id: restaurant.id
      }
    ]

    Enum.each(menus, fn menu ->
      Repo.insert!(menu)
    end)
  end)
end)
