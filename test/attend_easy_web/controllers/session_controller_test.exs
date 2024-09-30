defmodule AttendEasyWeb.SessionControllerTest do
  use AttendEasyWeb.ConnCase

  import AttendEasy.SessionsFixtures

  alias AttendEasy.Sessions.Session

  @create_attrs %{
    date: ~D[2024-09-29],
    session_type: "some session_type"
  }
  @update_attrs %{
    date: ~D[2024-09-30],
    session_type: "some updated session_type"
  }
  @invalid_attrs %{date: nil, session_type: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all sessions", %{conn: conn} do
      conn = get(conn, ~p"/api/sessions")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create session" do
    test "renders session when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/sessions", session: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/sessions/#{id}")

      assert %{
               "id" => ^id,
               "date" => "2024-09-29",
               "session_type" => "some session_type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/sessions", session: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update session" do
    setup [:create_session]

    test "renders session when data is valid", %{conn: conn, session: %Session{id: id} = session} do
      conn = put(conn, ~p"/api/sessions/#{session}", session: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/sessions/#{id}")

      assert %{
               "id" => ^id,
               "date" => "2024-09-30",
               "session_type" => "some updated session_type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, session: session} do
      conn = put(conn, ~p"/api/sessions/#{session}", session: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete session" do
    setup [:create_session]

    test "deletes chosen session", %{conn: conn, session: session} do
      conn = delete(conn, ~p"/api/sessions/#{session}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/sessions/#{session}")
      end
    end
  end

  defp create_session(_) do
    session = session_fixture()
    %{session: session}
  end
end
