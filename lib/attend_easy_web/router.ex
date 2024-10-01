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

    get "/classes", ClassController, :index
    post "/classes", ClassController, :create

    get "/classes/:class_id/students", StudentController, :index
    post "/classes/:class_id/students", StudentController, :create

    post "/classes/:class_id/sessions", SessionController, :create

    post "/sessions/:session_id/attendance", AttendanceController, :create
    put "/sessions/:session_id/attendance", AttendanceController, :update

    # post "/classes/:class_id/sessions/:sessions_id/attendances", AttendanceController, :create

    # get "/classes/:id", ClassController, :show
    # patch "/classes/:id", ClassController, :update
    # put "/classes/:id", ClassController, :update
    # delete "/classes/:id", ClassController, :delete

    # get "/students", StudentController, :index
    # get "/students/:id", StudentController, :show
    # post "/students", StudentController, :create
    # patch "/students/:id", StudentController, :update
    # put "/students/:id", StudentController, :update
    # delete "/students/:id", StudentController, :delete

    # get "/sessions", SessionController, :index
    # get "/sessions/:id", SessionController, :show
    # patch "/sessions/:id", SessionController, :update
    # put "/sessions/:id", SessionController, :update
    # delete "/sessions/:id", SessionController, :delete

    # get "/attendances", AttendanceController, :index
    # get "/attendances/:id", AttendanceController, :show
    # # post "/attendances", AttendanceController, :create
    # patch "/attendances/:id", AttendanceController, :update
    # put "/attendances/:id", AttendanceController, :update
    # delete "/attendances/:id", AttendanceController, :delete
  end
end
