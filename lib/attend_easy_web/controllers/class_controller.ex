defmodule AttendEasyWeb.ClassController do
  use AttendEasyWeb, :controller

  alias AttendEasy.Classes
  alias AttendEasy.Classes.Class

  action_fallback AttendEasyWeb.FallbackController

  def index(conn, _params) do
    classes = Classes.list_classes()
    render(conn, :index, classes: classes)
  end

  def create(conn, %{"class" => class_params}) do
    with {:ok, %Class{} = class} <- Classes.create_class(class_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/classes/#{class}")
      |> render(:show, class: class)
    end
  end

  def show(conn, %{"id" => id}) do
    class = Classes.get_class!(id)
    render(conn, :show, class: class)
  end

  def update(conn, %{"id" => id, "class" => class_params}) do
    class = Classes.get_class!(id)

    with {:ok, %Class{} = class} <- Classes.update_class(class, class_params) do
      render(conn, :show, class: class)
    end
  end

  def delete(conn, %{"id" => id}) do
    class = Classes.get_class!(id)

    with {:ok, %Class{}} <- Classes.delete_class(class) do
      send_resp(conn, :no_content, "")
    end
  end
end
