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
  def show(%{attendance: attendance}) do
    %{data: data(attendance)}
  end

  defp data(%Attendance{} = attendance) do
    %{
      id: attendance.id,
      is_present: attendance.is_present
    }
  end
end
