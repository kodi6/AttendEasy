defmodule AttendEasyWeb.SessionController do
  use AttendEasyWeb, :controller

  alias AttendEasy.Sessions
  alias AttendEasy.Sessions.Session
  alias AttendEasy.Students

  action_fallback AttendEasyWeb.FallbackController

  def index(conn, _params) do
    sessions = Sessions.list_sessions()
    render(conn, :index, sessions: sessions)
  end

  def create(conn, %{"class_id" => class_id, "session" => session_params}) do
    with {:ok, %Session{} = session} <- Sessions.create_session(class_id, session_params) do
      students = Students.list_students_by_class(class_id)

      conn
      |> put_status(:created)
      # |> put_resp_header("location", ~p"/api/sessions/#{session}")
      |> assign(:session, session)
      |> assign(:students, students)
      |> render(:show)
    end
  end

  def show(conn, %{"id" => id}) do
    session = Sessions.get_session!(id)
    render(conn, :show, session: session)
  end

  def update(conn, %{"id" => id, "session" => session_params}) do
    session = Sessions.get_session!(id)

    with {:ok, %Session{} = session} <- Sessions.update_session(session, session_params) do
      render(conn, :show, session: session)
    end
  end

  def delete(conn, %{"id" => id}) do
    session = Sessions.get_session!(id)

    with {:ok, %Session{}} <- Sessions.delete_session(session) do
      send_resp(conn, :no_content, "")
    end
  end
end
