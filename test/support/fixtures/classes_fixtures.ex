defmodule AttendEasy.ClassesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AttendEasy.Classes` context.
  """

  @doc """
  Generate a class.
  """
  def class_fixture(attrs \\ %{}) do
    {:ok, class} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> AttendEasy.Classes.create_class()

    class
  end
end
