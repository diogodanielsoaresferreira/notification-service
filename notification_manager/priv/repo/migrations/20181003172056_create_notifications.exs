defmodule Notifications.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add :title, :text
      add :content, :text
      add :app, :boolean, default: true, null: false
      add :sms, :boolean, default: false, null: false
      add :email, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

  end
end
