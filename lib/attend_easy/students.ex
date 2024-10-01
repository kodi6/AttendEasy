defmodule AttendEasy.Students do
  @moduledoc """
  The Students context.
  """

  import Ecto.Query, warn: false
  alias AttendEasy.Repo

  alias AttendEasy.Students.Student
  alias AttendEasy.Sessions

  alias AttendEasy.Attendances

  @doc """
  Returns the list of students.

  ## Examples

      iex> list_students()
      [%Student{}, ...]

  """
  def list_students do
    Repo.all(Student)
  end

  def list_students_by_class(class_id) do
    Student
    |> where([s], s.class_id == ^class_id)
    |> Repo.all()
  end

  @doc """
  Gets a single student.

  Raises `Ecto.NoResultsError` if the Student does not exist.

  ## Examples

      iex> get_student!(123)
      %Student{}

      iex> get_student!(456)
      ** (Ecto.NoResultsError)

  """
  def get_student!(id), do: Repo.get!(Student, id)

  @doc """
  Creates a student.

  ## Examples

      iex> create_student(%{field: value})
      {:ok, %Student{}}

      iex> create_student(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_student(class_id, attrs \\ %{}) do
    attrs = Map.put(attrs, "class_id", class_id)

    %Student{}
    |> Student.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a student.

  ## Examples

      iex> update_student(student, %{field: new_value})
      {:ok, %Student{}}

      iex> update_student(student, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_student(%Student{} = student, attrs) do
    student
    |> Student.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a student.

  ## Examples

      iex> delete_student(student)
      {:ok, %Student{}}

      iex> delete_student(student)
      {:error, %Ecto.Changeset{}}

  """
  def delete_student(%Student{} = student) do
    Repo.delete(student)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking student changes.

  ## Examples

      iex> change_student(student)
      %Ecto.Changeset{data: %Student{}}

  """
  def change_student(%Student{} = student, attrs \\ %{}) do
    Student.changeset(student, attrs)
  end

  def mark_present_students(session_id, absentee_ids) do
    class_id = Sessions.get_session!(session_id).class_id

    present_students_query =
      from(s in Student,
        where: s.class_id == ^class_id and s.id not in ^absentee_ids,
        select: %{student_id: s.id}
      )

    present_students = Repo.all(present_students_query)

    Enum.map(present_students, fn present_student ->
      {:ok, attendance} =
        Attendances.create_attendance(%{
          student_id: present_student.student_id,
          session_id: session_id,
          is_present: true
        })

      attendance.id
    end)
  end
end
