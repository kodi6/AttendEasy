defmodule AttendEasy.SessionsTest do
  use AttendEasy.DataCase

  alias AttendEasy.Sessions

  describe "sessions" do
    alias AttendEasy.Sessions.Session

    import AttendEasy.SessionsFixtures

    @invalid_attrs %{date: nil, session_type: nil}

    test "list_sessions/0 returns all sessions" do
      session = session_fixture()
      assert Sessions.list_sessions() == [session]
    end

    test "get_session!/1 returns the session with given id" do
      session = session_fixture()
      assert Sessions.get_session!(session.id) == session
    end

    test "create_session/1 with valid data creates a session" do
      valid_attrs = %{date: ~D[2024-09-29], session_type: "some session_type"}

      assert {:ok, %Session{} = session} = Sessions.create_session(valid_attrs)
      assert session.date == ~D[2024-09-29]
      assert session.session_type == "some session_type"
    end

    test "create_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sessions.create_session(@invalid_attrs)
    end

    test "update_session/2 with valid data updates the session" do
      session = session_fixture()
      update_attrs = %{date: ~D[2024-09-30], session_type: "some updated session_type"}

      assert {:ok, %Session{} = session} = Sessions.update_session(session, update_attrs)
      assert session.date == ~D[2024-09-30]
      assert session.session_type == "some updated session_type"
    end

    test "update_session/2 with invalid data returns error changeset" do
      session = session_fixture()
      assert {:error, %Ecto.Changeset{}} = Sessions.update_session(session, @invalid_attrs)
      assert session == Sessions.get_session!(session.id)
    end

    test "delete_session/1 deletes the session" do
      session = session_fixture()
      assert {:ok, %Session{}} = Sessions.delete_session(session)
      assert_raise Ecto.NoResultsError, fn -> Sessions.get_session!(session.id) end
    end

    test "change_session/1 returns a session changeset" do
      session = session_fixture()
      assert %Ecto.Changeset{} = Sessions.change_session(session)
    end
  end
end
