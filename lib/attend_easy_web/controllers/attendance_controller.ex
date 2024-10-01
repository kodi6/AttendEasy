defmodule AttendEasyWeb.AttendanceController do
  use AttendEasyWeb, :controller

  alias AttendEasy.Attendances
  alias AttendEasy.Attendances.Attendance
  alias AttendEasy.Sessions
  alias AttendEasy.Students

  action_fallback AttendEasyWeb.FallbackController

  def index(conn, _params) do
    attendances = Attendances.list_attendances()
    render(conn, :index, attendances: attendances)
  end

  def create(conn, %{"session_id" => session_id, "absentees" => absentees}) do
    class_id = Sessions.get_session!(session_id).class_id

    students = Students.list_students_by_class(class_id)

    absentee_ids = Enum.map(absentees, fn absentee -> absentee["student_id"] end)

    update_absentees =
      Enum.map(absentees, fn absentee ->
        attrs = %{
          session_id: session_id,
          student_id: absentee["student_id"],
          is_present: absentee["is_present"]
        }

        Attendances.create_attendance(attrs)
      end)

    presentee_ids = Students.mark_present_students(session_id, absentee_ids)

    conn
    |> put_status(:created)
    |> assign(:absentee_ids, absentee_ids)
    |> assign(:session_id, session_id)
    |> assign(:presentee_ids, presentee_ids)
    |> render(:show)
  end

  def show(conn, %{"id" => id}) do
    attendance = Attendances.get_attendance!(id)
    render(conn, :show, attendance: attendance)
  end

  def update(conn, %{"session_id" => _session_id, "updates" => updates}) do
    update_attendances =
      Enum.map(updates, fn attendance ->
        get_attendance = Attendances.get_attendance_by_student(attendance["student_id"])

        {:ok, updated_attendance} =
          Attendances.update_attendance(get_attendance, %{is_present: attendance["is_present"]})

        updated_attendance.student_id
      end)

    conn
    |> assign(:update_attendances, update_attendances)
    |> render(:update)
  end

  def delete(conn, %{"id" => id}) do
    attendance = Attendances.get_attendance!(id)

    with {:ok, %Attendance{}} <- Attendances.delete_attendance(attendance) do
      send_resp(conn, :no_content, "")
    end
  end
end
