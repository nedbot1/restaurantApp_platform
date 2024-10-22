# priv/repo/seeds.exs
alias RestaurantAppPlatform.Repo
alias RestaurantAppPlatform.Accounts.Account
alias RestaurantAppPlatform.Restaurants.Restaurant
alias RestaurantAppPlatform.Menus.Menu
alias RestaurantAppPlatform.Tables.Table
alias RestaurantAppPlatform.Categories.Category

# Initialize the faker
Faker.start()

alias Bcrypt

# create users
category = [
  %Category{
    name: "Drinks"
  },
  %Category{
    name: "Appetizers"
  },
  %Category{
    name: "Main Course"
  },
  %Category{
    name: "Dessert"
  }
]

# Insert data into the database
categories = Enum.map(category, fn category ->
  Repo.insert!(category)
end)

accounts = [
  %Account{
    owner_name: "tobdhen",
    email: "tobdhen@gmail.com",
    password_hash: Bcrypt.hash_pwd_salt("1234"),
    phone_number: "17661088"
  },
  %Account{
    owner_name: "sherab",
    email: "sherab@gmail.com",
    password_hash: Bcrypt.hash_pwd_salt("1234"),
    phone_number: "77223344"
  },
  %Account{
    owner_name: "passang",
    email: "passang@gmail.com",
    password_hash: Bcrypt.hash_pwd_salt("1234"),
    phone_number: "77223344"
  },
  %Account{
    owner_name: "pema",
    email: "pema@gmail.com",
    password_hash: Bcrypt.hash_pwd_salt("1234"),
    phone_number: "77223344"
  },
  %Account{
    owner_name: "sangay",
    email: "sangay@gmail.com",
    password_hash: Bcrypt.hash_pwd_salt("1234"),
    phone_number: "77223344"
  },
  %Account{
    owner_name: "Chakhar",
    email: "Chakhar@gmail.com",
    password_hash: Bcrypt.hash_pwd_salt("1234"),
    phone_number: "77223344"
  }
]

# Insert data into the database
Enum.each(accounts, fn account ->
  account = Repo.insert!(account)
  # create restaurants
  restaurant = %Restaurant{
    name: account.owner_name,
    location: Faker.Address.city(),
    contact_number: account.phone_number,
    account_id: account.id
  }
  restaurant = Repo.insert!(restaurant)

  # create menus
  menus = [
    %Menu{
      item_name: "pork-ribs",
      item_description: "Juicy hot and tender pork meat and ribs",
      price: 220,
      dish_photo_link:
        "https://www.southernliving.com/thmb/J02EQeOhOKHfmALt-jE_61idUck=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/oven-baked-baby-back-ribs-beauty-332-7deda00b7b4f4820a9c79f13ed09cfb9.jpg",
      restaurant_id: restaurant.id,
      category_id: Enum.find(categories, fn c -> c.name == "Main Course" end).id
    },
    %Menu{
      item_name: "beef jerky",
      item_description: "Juicy hot and tender meat and ribs",
      price: 100,
      dish_photo_link:
        "https://img.freepik.com/free-photo/raw-meats-with-spices-utensils-rustic-cutting-board-dark-wood-top-view-ai-generative_123827-23528.jpg",
      restaurant_id: restaurant.id,
      category_id: Enum.find(categories, fn c -> c.name == "Appetizers" end).id
    }
  ]
  Enum.each(menus, fn menu ->
    Repo.insert!(menu)
  end)
end)
