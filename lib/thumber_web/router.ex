defmodule ThumberWeb.Router do
  use ThumberWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ThumberWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ThumberWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ThumberWeb.Telemetry
    end
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "Thumber - Image Service",
        basePath: "/api",
      }
    }
  end
end
