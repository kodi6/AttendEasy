defmodule AttendEasy.Attendances.Attendance do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "attendances" do
    field :is_present, :boolean, default: true
    belongs_to :student, AttendEasy.Students.Student
    belongs_to :session, AttendEasy.Sessions.Session

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(attendance, attrs) do
    attendance
    |> cast(attrs, [:is_present, :session_id, :student_id])

    # |> validate_required([:is_present, :session_id, :student_id])
  end
end
