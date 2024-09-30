defmodule AttendEasy.AttendancesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AttendEasy.Attendances` context.
  """

  @doc """
  Generate a attendance.
  """
  def attendance_fixture(attrs \\ %{}) do
    {:ok, attendance} =
      attrs
      |> Enum.into(%{
        is_present: true
      })
      |> AttendEasy.Attendances.create_attendance()

    attendance
  end
end
