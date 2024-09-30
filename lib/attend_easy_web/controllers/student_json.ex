defmodule AttendEasyWeb.StudentJSON do
  alias AttendEasy.Students.Student

  @doc """
  Renders a list of students.
  """
  def index(%{students: students}) do
    %{data: for(student <- students, do: data(student))}
  end

  @doc """
  Renders a single student.
  """
  def show(%{student: student}) do
    %{data: data(student)}
  end

  defp data(%Student{} = student) do
    %{
      id: student.id,
      name: student.name
    }
  end
end
