defmodule AttendEasy.AttendancesTest do
  use AttendEasy.DataCase

  alias AttendEasy.Attendances

  describe "attendances" do
    alias AttendEasy.Attendances.Attendance

    import AttendEasy.AttendancesFixtures

    @invalid_attrs %{is_present: nil}

    test "list_attendances/0 returns all attendances" do
      attendance = attendance_fixture()
      assert Attendances.list_attendances() == [attendance]
    end

    test "get_attendance!/1 returns the attendance with given id" do
      attendance = attendance_fixture()
      assert Attendances.get_attendance!(attendance.id) == attendance
    end

    test "create_attendance/1 with valid data creates a attendance" do
      valid_attrs = %{is_present: true}

      assert {:ok, %Attendance{} = attendance} = Attendances.create_attendance(valid_attrs)
      assert attendance.is_present == true
    end

    test "create_attendance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Attendances.create_attendance(@invalid_attrs)
    end

    test "update_attendance/2 with valid data updates the attendance" do
      attendance = attendance_fixture()
      update_attrs = %{is_present: false}

      assert {:ok, %Attendance{} = attendance} =
               Attendances.update_attendance(attendance, update_attrs)

      assert attendance.is_present == false
    end

    test "update_attendance/2 with invalid data returns error changeset" do
      attendance = attendance_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Attendances.update_attendance(attendance, @invalid_attrs)

      assert attendance == Attendances.get_attendance!(attendance.id)
    end

    test "delete_attendance/1 deletes the attendance" do
      attendance = attendance_fixture()
      assert {:ok, %Attendance{}} = Attendances.delete_attendance(attendance)
      assert_raise Ecto.NoResultsError, fn -> Attendances.get_attendance!(attendance.id) end
    end

    test "change_attendance/1 returns a attendance changeset" do
      attendance = attendance_fixture()
      assert %Ecto.Changeset{} = Attendances.change_attendance(attendance)
    end
  end
end
