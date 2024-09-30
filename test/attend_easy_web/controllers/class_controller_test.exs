defmodule AttendEasyWeb.ClassControllerTest do
  use AttendEasyWeb.ConnCase

  import AttendEasy.ClassesFixtures

  alias AttendEasy.Classes.Class

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all classes", %{conn: conn} do
      conn = get(conn, ~p"/api/classes")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create class" do
    test "renders class when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/classes", class: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/classes/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/classes", class: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update class" do
    setup [:create_class]

    test "renders class when data is valid", %{conn: conn, class: %Class{id: id} = class} do
      conn = put(conn, ~p"/api/classes/#{class}", class: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/classes/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, class: class} do
      conn = put(conn, ~p"/api/classes/#{class}", class: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete class" do
    setup [:create_class]

    test "deletes chosen class", %{conn: conn, class: class} do
      conn = delete(conn, ~p"/api/classes/#{class}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/classes/#{class}")
      end
    end
  end

  defp create_class(_) do
    class = class_fixture()
    %{class: class}
  end
end
