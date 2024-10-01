defmodule AttendEasyWeb.ClassJSON do
  alias AttendEasy.Classes.Class

  @doc """
  Renders a list of classes.
  """
  def index(%{classes: classes}) do
    %{
      status: "success",
      classes: for(class <- classes, do: data(class))
    }
  end

  @doc """
  Renders a single class.
  """
  def show(%{class: class}) do
    %{data: data(class)}
  end

  defp data(%Class{} = class) do
    %{
      id: class.id,
      name: class.name
    }
  end
end
