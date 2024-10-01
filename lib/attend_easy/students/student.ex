defmodule AttendEasy.Students.Student do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "students" do
    field :name, :string
    belongs_to :class, AttendEasy.Classes.Class
    has_many :attendances, AttendEasy.Attendances.Attendance

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:name, :class_id])
    |> validate_required([:name, :class_id])
  end
end
