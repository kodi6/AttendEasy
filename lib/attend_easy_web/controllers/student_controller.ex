defmodule AttendEasyWeb.StudentController do
  use AttendEasyWeb, :controller

  alias AttendEasy.Students
  alias AttendEasy.Students.Student

  action_fallback AttendEasyWeb.FallbackController

  def index(conn, _params) do
    students = Students.list_students()
    render(conn, :index, students: students)
  end

  def create(conn, %{"class_id" => class_id, "student" => student_params}) do
    with {:ok, %Student{} = student} <- Students.create_student(class_id, student_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/students/#{student}")
      |> render(:show, student: student)
    end
  end

  def show(conn, %{"id" => id}) do
    student = Students.get_student!(id)
    render(conn, :show, student: student)
  end

  def update(conn, %{"id" => id, "student" => student_params}) do
    student = Students.get_student!(id)

    with {:ok, %Student{} = student} <- Students.update_student(student, student_params) do
      render(conn, :show, student: student)
    end
  end

  def delete(conn, %{"id" => id}) do
    student = Students.get_student!(id)

    with {:ok, %Student{}} <- Students.delete_student(student) do
      send_resp(conn, :no_content, "")
    end
  end
end
