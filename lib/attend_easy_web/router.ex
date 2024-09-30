defmodule AttendEasyWeb.Router do
  use AttendEasyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AttendEasyWeb do
    pipe_through :api

    # resources "/classes", ClassController, except: [:new, :edit]
    # resources "/students", StudentController, except: [:new, :edit]
    # resources "/sessions", SessionController, except: [:new, :edit]
    # resources "/attendances", AttendanceController, except: [:new, :edit]

    get "/api/classes", ClassController, :index
    get "/api/classes/:id", ClassController, :show
    post "/api/classes", ClassController, :create
    patch "/api/classes/:id", ClassController, :update
    put "/api/classes/:id", ClassController, :update
    delete "/api/classes/:id", ClassController, :delete

    get "/api/students", StudentController, :index
    get "/api/students/:id", StudentController, :show
    post "/api/students", StudentController, :create
    patch "/api/students/:id", StudentController, :update
    put "/api/students/:id", StudentController, :update
    delete "/api/students/:id", StudentController, :delete

    get "/api/sessions", SessionController, :index
    get "/api/sessions/:id", SessionController, :show
    post "/api/sessions", SessionController, :create
    patch "/api/sessions/:id", SessionController, :update
    put "/api/sessions/:id", SessionController, :update
    delete "/api/sessions/:id", SessionController, :delete

    get "/api/attendances", AttendanceController, :index
    get "/api/attendances/:id", AttendanceController, :show
    post "/api/attendances", AttendanceController, :create
    patch "/api/attendances/:id", AttendanceController, :update
    put "/api/attendances/:id", AttendanceController, :update
    delete "/api/attendances/:id", AttendanceController, :delete
  end
end
