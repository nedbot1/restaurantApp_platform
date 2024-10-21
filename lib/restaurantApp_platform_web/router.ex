defmodule RestaurantAppPlatformWeb.Router do
  use RestaurantAppPlatformWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
  conn |> json(%{errors: message}) |> halt()
   end

  defp handle_errors(conn, %{reason: reason}) do
  message = case reason do
    %{message: message} -> message
    _ -> "An unknown error occurred."
  end

  conn |> json(%{errors: message}) |> halt()
end

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug
  end

  scope "/api", RestaurantAppPlatformWeb do
    pipe_through :api

    # post "/register", AuthController, :register
    # post "/login", AuthController, :login

    post "/accounts/create", AccountController, :create
    post "/accounts/sign_in", AccountController, :sign_in
    resources "/accounts", AccountController, except: [:new, :edit]
    post "/accounts/:id/subscribe", AccountController, :subscribe_to_premium

    resources "/restaurants", RestaurantController, except: [:new, :edit]
    get "/restaurants/account/:account_id", RestaurantController, :show_by_account

    resources "/tables", TableController, except: [:new, :edit]
    post "/tables/batch", TableController, :create_batch
    post "/tables/:id/regenerate_qr_code", TableController, :regenerate_qr_code
    get "/tables/by_restaurant/:restaurant_id", TableController, :get_tables_by_restaurant_id

    resources "/menus", MenuController, except: [:new, :edit]
    post "/menus/batch", MenuController, :create_batch

    resources "/sessions", SessionController, except: [:new, :edit]
    post "/sessions/:id/end", SessionController, :end_session

    get "/orders/unpaid", OrderController, :unpaid_orders
    resources "/orders", OrderController, except: [:new, :edit]
    get "/orders/restaurant/:restaurant_id", OrderController, :index_by_restaurant

    resources "/order_lists", OrderListController, except: [:new, :edit]

     resources "/categories", CategoryController, except: [:new, :edit]

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
