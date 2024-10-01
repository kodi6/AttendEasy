defmodule AttendEasyWeb.SessionJSON do
  alias AttendEasy.Sessions.Session

  @doc """
  Renders a list of sessions.
  """
  def index(%{sessions: sessions}) do
    %{data: for(session <- sessions, do: data(session))}
  end

  @doc """
  Renders a single session.
  """
  def show(%{session: session, students: students}) do
    %{
      status: "success",
      session_id: session.id,
      class_id: session.class_id,
      date: session.date,
      session_type: session.session_type,
      students: render_students(students)
    }
  end

  defp data(%Session{} = session) do
    %{
      session_id: session.id,
      class_id: session.class_id,
      date: session.date,
      session_type: session.session_type
    }
  end

  def render_students(students) do
    for student <- students do
      %{
        id: student.id,
        name: student.name
      }
    end
  end
end
