defmodule ThumberWeb.Router do
  alias ThumberWeb.PageController
  use ThumberWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ThumberWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers, %{"cross-origin-policy" => "default-src 'self'"}
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Ueberauth
  end

  scope "/" do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/auth", ThumberWeb do
    pipe_through :browser

    get "/github", AuthController, :request
    get "/github/callback", AuthController, :callback
    get "/github/callback/sovereign", AuthController, :callback_sovereign
  end

  scope "/api", ThumberWeb do
    pipe_through :api

    post "/resize", ImageController, :resize
    post "/enlarge", ImageController, :enlarge
    post "/crop", ImageController, :crop
    post "/rotate", ImageController, :rotate
    post "/thumbnail", ImageController, :thumbnail
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :thumber, swagger_file: "swagger.json"
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

  if Application.compile_env(:thumber, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ThumberWeb.Telemetry
    end
  end
end
