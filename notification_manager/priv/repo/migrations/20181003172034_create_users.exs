defmodule Notifications.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :phone, :string
      add :apikey, :string
      add :app_enabled, :boolean, default: true, null: false
      add :sms_enabled, :boolean, default: true, null: false
      add :email_enabled, :boolean, default: true, null: false

      timestamps()
    end

  end
end
