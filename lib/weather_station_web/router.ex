defmodule WeatherStationWeb.Router do
  use WeatherStationWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WeatherStationWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/entries", EntryController, only: [:index, :create]
  end

  scope "/api", WeatherStationWeb.Api, as: :api do
    pipe_through :api

    resources "/entries", EntryController, only: [:index, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", WeatherStationWeb do
  #   pipe_through :api
  # end
end
