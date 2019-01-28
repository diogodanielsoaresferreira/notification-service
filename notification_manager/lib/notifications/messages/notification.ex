defmodule Notifications.Messages.Notification do
  use Ecto.Schema
  import Ecto.Changeset
  alias Notifications.Repo
  alias Notifications.PointOfContact.User


  schema "notifications" do
    field :title, :string
    field :content, :string
    field :app, :boolean, default: true
    field :email, :boolean, default: false
    field :sms, :boolean, default: false
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(notification, attrs) do
    notification
    |> cast(attrs, [:title, :content, :app, :sms, :email, :user_id])
    |> validate_required([:title, :content, :app, :sms, :email, :user_id])
    |> foreign_key_constraint(:user_id)
    |> user_exists
    |> point_of_contact_is_enabled
  end

  defp user_exists(%Ecto.Changeset{} = changes) do

    case (changes.valid? and Map.has_key?(changes.params, "user_id")) do

      true -> 
        if Repo.get(User, changes.changes.user_id) == nil do
          add_error(changes, :user_id, "User does not exist")
        else
          changes
        end

      false -> changes
    end
  end

  defp point_of_contact_is_enabled(%Ecto.Changeset{} = changes) do

    user = Repo.get(User, changes.changes.user_id)
    notification_to_app = if Map.has_key?(changes.params, "app"), do: changes.params["app"], else: true
    notification_to_email = if Map.has_key?(changes.params, "email"), do: changes.params["email"], else: false
    notification_to_sms = if Map.has_key?(changes.params, "sms"), do: changes.params["sms"], else: false
  
    changes = 
      if !notification_to_email and !notification_to_sms and !notification_to_app do
        add_error(changes, :app, "No service was found to send the message")
      else
        changes
      end

    changes = 
      if user != nil and notification_to_email and !user.email_enabled do
        add_error(changes, :email, "User does not have e-mail notifications active")
      else
        changes
      end

    changes = 
      if user != nil and notification_to_app and !user.app_enabled do
        add_error(changes, :app, "User does not have app notifications active")
      else
        changes
      end

    changes = 
      if user != nil and notification_to_sms and !user.sms_enabled do
        add_error(changes, :sms, "User does not have sms notifications active")
      else
        changes
      end
    changes
  end

end
