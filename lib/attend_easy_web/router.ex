defmodule AttendEasyWeb.Router do
  use AttendEasyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AttendEasyWeb do
    pipe_through :api

    resources "/classes", ClassController, except: [:new, :edit]
    resources "/students", StudentController, except: [:new, :edit]
    resources "/sessions", SessionController, except: [:new, :edit]
    resources "/attendances", AttendanceController, except: [:new, :edit]
  end
end
