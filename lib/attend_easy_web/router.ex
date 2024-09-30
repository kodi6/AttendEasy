defmodule AttendEasyWeb.Router do
  use AttendEasyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AttendEasyWeb do
    pipe_through :api

    resources "/classes", ClassController, except: [:new, :edit]
  end
end
