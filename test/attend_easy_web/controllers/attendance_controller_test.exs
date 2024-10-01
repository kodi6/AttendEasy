defmodule AttendEasyWeb.AttendanceControllerTest do
  use AttendEasyWeb.ConnCase

  import AttendEasy.AttendancesFixtures

  alias AttendEasy.Attendances.Attendance

  @create_attrs %{
    is_present: true
  }
  @update_attrs %{
    is_present: false
  }
  @invalid_attrs %{is_present: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all attendances", %{conn: conn} do
      conn = get(conn, ~p"/api/attendances")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create attendance" do
    test "renders attendance when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/attendances", attendance: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/attendances/#{id}")

      assert %{
               "id" => ^id,
               "is_present" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/attendances", attendance: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update attendance" do
    setup [:create_attendance]

    test "renders attendance when data is valid", %{
      conn: conn,
      attendance: %Attendance{id: id} = attendance
    } do
      conn = put(conn, ~p"/api/attendances/#{attendance}", attendance: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/attendances/#{id}")

      assert %{
               "id" => ^id,
               "is_present" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, attendance: attendance} do
      conn = put(conn, ~p"/api/attendances/#{attendance}", attendance: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete attendance" do
    setup [:create_attendance]

    test "deletes chosen attendance", %{conn: conn, attendance: attendance} do
      conn = delete(conn, ~p"/api/attendances/#{attendance}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/attendances/#{attendance}")
      end
    end
  end

  defp create_attendance(_) do
    attendance = attendance_fixture()
    %{attendance: attendance}
  end
end
