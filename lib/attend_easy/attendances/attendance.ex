defmodule AttendEasy.Attendances.Attendance do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "attendances" do
    field :is_present, :boolean, default: false
    field :student_id, :binary_id
    field :session_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(attendance, attrs) do
    attendance
    |> cast(attrs, [:is_present])
    |> validate_required([:is_present])
  end
end
