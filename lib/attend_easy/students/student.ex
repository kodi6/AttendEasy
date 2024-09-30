defmodule AttendEasy.Students.Student do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "students" do
    field :name, :string
    field :class_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
