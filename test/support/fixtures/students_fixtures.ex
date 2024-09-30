defmodule AttendEasy.StudentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AttendEasy.Students` context.
  """

  @doc """
  Generate a student.
  """
  def student_fixture(attrs \\ %{}) do
    {:ok, student} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> AttendEasy.Students.create_student()

    student
  end
end
