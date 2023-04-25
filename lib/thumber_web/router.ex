defmodule ThumberWeb.Router do
  use ThumberWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ThumberWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers, %{"cross-origin-policy" => "default-src 'self';"}
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Ueberauth
  end

  scope "/auth", ThumberWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback

    get "/", PageController, :index
  end

  scope "/api", ThumberWeb do
    pipe_through :api

    get "/", PageController, :index
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "Thumber - Image service",
        basePath: "/api"
      }
    }
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:thumber, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ThumberWeb.Telemetry
    end
  end
end
