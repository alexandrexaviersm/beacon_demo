defmodule BeaconDemoWeb.Router do
  use BeaconDemoWeb, :router
  use Beacon.Router
  use Beacon.LiveAdmin.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BeaconDemoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Beacon.LiveAdmin.Plug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", host: ["demo1.ngrok.dev"] do
    pipe_through :browser

    beacon_site "/demo", site: :demo
  end

  scope "/", host: ["blog1.ngrok.dev"] do
    pipe_through :browser

    beacon_site "/blog", site: :blog
  end

  scope "/admin" do
    pipe_through :browser
    beacon_live_admin "/"
  end

  scope "/page_management_api" do
    pipe_through :api
    beacon_api "/"
  end

  scope "/", BeaconDemoWeb do
    pipe_through :browser

    get "/", PageController, :home
  end
end
