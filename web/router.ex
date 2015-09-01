defmodule Spell.Router do
  use Spell.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Spell do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", Spell do
    pipe_through :api

    scope "/v1/chat" do
      get "/messages", MessageController, :index
    end
  end
end
