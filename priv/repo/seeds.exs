# priv/repo/seeds.exs
alias RestaurantAppPlatform.Repo
alias RestaurantAppPlatform.Accounts.Account
alias RestaurantAppPlatform.Restaurants.Restaurant
alias RestaurantAppPlatform.Menus.Menu
alias RestaurantAppPlatform.Tables.Table
alias RestaurantAppPlatform.Categories.Category
alias RestaurantAppPlatform.Users.User
alias RestaurantAppPlatform.Sessions.Session
alias RestaurantAppPlatform.OrderLists.OrderList
alias RestaurantAppPlatform.Orders.Order

import RestaurantAppPlatform.Tables, only: [create_qrCode: 2]
import RestaurantAppPlatform.Sessions, only: [generate_token: 0]
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
    email: "tobdhen@gmail.com",
    hash_password: Bcrypt.hash_pwd_salt("1234")
  },
  %Account{
    email: "sherab@gmail.com",
    hash_password: Bcrypt.hash_pwd_salt("1234")
  },
  %Account{
    email: "passang@gmail.com",
    hash_password: Bcrypt.hash_pwd_salt("1234"),
  },
  %Account{
    email: "pema@gmail.com",
    hash_password: Bcrypt.hash_pwd_salt("1234"),
  },
  %Account{
    email: "sangay@gmail.com",
    hash_password: Bcrypt.hash_pwd_salt("1234"),
  },
  %Account{
    email: "chakhar@gmail.com",
    hash_password: Bcrypt.hash_pwd_salt("1234"),
  }
]

# Insert data into the database
Enum.each(accounts, fn account ->
  account = Repo.insert!(account)
  #create user
  user = %User{
    full_name: Regex.replace(~r/@.+/, account.email, ""),
    account_id: account.id
  }
  user = Repo.insert!(user)

  # create restaurants
  restaurant = %Restaurant{
    name: user.full_name <> " restaurant",
    location: Faker.Address.city(),
    contact_number: "+975" <> Faker.Phone.EnUs.phone(),
    account_id: account.id
  }
  restaurant = Repo.insert!(restaurant)

  # create menus
  menu = [
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
 menus = Enum.map(menu, fn menu ->
  Repo.insert!(menu)
 end)

  # create tables
  table = [
    %Table{
      table_number: "1",
      restaurant_id: restaurant.id,
      qr_code: create_qrCode("1", restaurant.id)
    },
    %Table{
      table_number: "2",
      restaurant_id: restaurant.id,
      qr_code: create_qrCode("2", restaurant.id)
    }
  ]
  tables = Enum.map(table, fn table->
  Repo.insert!(table)
end)

  # create sessions
  session =
    %Session{
      table_id: Enum.at(tables, 0).id,
      session_token: generate_token(),
      start_time: DateTime.utc_now(:second),
      end_time: DateTime.add(DateTime.utc_now(:second), 3600, :second)
    }
  session = Repo.insert!(session)

  # create orders
  order =
    %Order{
      session_id: session.id,
      restaurant_id: restaurant.id,
      total_amount: 320,
    }
  order = Repo.insert!(order)

  # create order_lists
  order_list = [
    %OrderList{
      quantity: 1,
      total_price: Enum.at(menus, 0).price,
      menu_item_id: Enum.at(menus, 0).id,
      order_id: order.id
    },
    %OrderList{
      quantity: 1,
      total_price: Enum.at(menus, 1).price,
      menu_item_id: Enum.at(menus, 1).id,
      order_id: order.id
    }
  ]
  order_list = Enum.map(order_list, fn order_list ->
    Repo.insert!(order_list)
  end)
end)
