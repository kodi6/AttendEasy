defmodule AttendEasy.SessionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AttendEasy.Sessions` context.
  """

  @doc """
  Generate a session.
  """
  def session_fixture(attrs \\ %{}) do
    {:ok, session} =
      attrs
      |> Enum.into(%{
        date: ~D[2024-09-29],
        session_type: "some session_type"
      })
      |> AttendEasy.Sessions.create_session()

    session
  end
end
