defmodule AttendEasy.Sessions.Session do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "sessions" do
    field :date, :date
    field :session_type, :string
    belongs_to :class, AttendEasy.Classes.Class
    has_many :attendances, AttendEasy.Attendances.Attendance

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:date, :session_type, :class_id])
    |> validate_required([:date, :session_type, :class_id])
  end
end
