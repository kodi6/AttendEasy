defmodule AttendEasy.Sessions.Session do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "sessions" do
    field :date, :date
    field :session_type, :string
    field :class_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:date, :session_type])
    |> validate_required([:date, :session_type])
  end
end
