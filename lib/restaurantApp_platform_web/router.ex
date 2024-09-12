defmodule RestaurantAppPlatformWeb.Router do
  use RestaurantAppPlatformWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RestaurantAppPlatformWeb do
    pipe_through :api

    options "/*path", CORSPlug, :options
    resources "/accounts", AccountController, except: [:new, :edit]

    resources "/restaurants", RestaurantController, except: [:new, :edit]
    post "/accounts/:id/subscribe", AccountController, :subscribe_to_premium


    resources "/tables", TableController, except: [:new, :edit]
    # Route for batch creation of tables
    post "/tables/batch", TableController, :create_batch

    resources "/menus", MenuController, except: [:new, :edit]
    post "/menus/batch", MenuController, :create_batch

    resources "/sessions", SessionController, except: [:new, :edit]
    post "/sessions/:id/end", SessionController, :end_session

    get "/orders/unpaid", OrderController, :unpaid_orders
    resources "/orders", OrderController, except: [:new, :edit]

    resources "/order_lists", OrderListController, except: [:new, :edit]

  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:restaurantApp_platform, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: RestaurantAppPlatformWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
