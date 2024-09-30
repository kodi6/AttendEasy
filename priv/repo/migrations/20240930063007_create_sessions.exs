defmodule AttendEasy.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :date, :date
      add :session_type, :string
      add :class_id, references(:classes, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:sessions, [:class_id])
  end
end
