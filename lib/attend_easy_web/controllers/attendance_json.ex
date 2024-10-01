defmodule AttendEasyWeb.AttendanceJSON do
  alias AttendEasy.Attendances.Attendance

  @doc """
  Renders a list of attendances.
  """
  def index(%{attendances: attendances}) do
    %{data: for(attendance <- attendances, do: data(attendance))}
  end

  @doc """
  Renders a single attendance.
  """
  def show(%{absentee_ids: absentee_ids, session_id: session_id, presentee_ids: presentee_ids}) do
    %{
      status: "success",
      session_id: session_id,
      absentees: render_absentee_ids(absentee_ids),
      Presentees: render_Presentee_ids(presentee_ids)
    }
  end

  defp data(%Attendance{} = attendance) do
    %{
      id: attendance.id,
      is_present: attendance.is_present
    }
  end

  def render_absentee_ids(absentee_ids) do
    for absentee_id <- absentee_ids do
      %{
        student_id: absentee_id
      }
    end
  end

  def render_Presentee_ids(presentee_ids) do
    for presentee_id <- presentee_ids do
      %{
        student_id: presentee_id
      }
    end
  end

  def update(%{update_attendances: update_attendances}) do
    %{
      status: "success",
      message: "Attendances updated successfully",
      updated_attendances: render_updated_attendances(update_attendances)
    }
  end

  defp render_updated_attendances(attendance_ids) do
    for attendance_id <- attendance_ids do
      %{
        student_id: attendance_id
      }
    end
  end
end
