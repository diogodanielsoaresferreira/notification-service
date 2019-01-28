defmodule Notifications.PointOfContact.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :phone, :string
    field :apikey, :string
    field :app_enabled, :boolean, default: true
    field :sms_enabled, :boolean, default: true
    field :email_enabled, :boolean, default: true

    timestamps()
  end

  @required_fields ~w()a
  @optional_fields ~w(apikey email phone app_enabled sms_enabled email_enabled)a

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_format(:phone, ~r/^[0-9]+$/)
    |> at_least_one_point_of_contact_exists
    |> chosen_services_contain_point_of_contact
  end

  defp at_least_one_point_of_contact_exists(%Ecto.Changeset{} = changeset) do
    user = changeset.data
    changes = changeset.changes

    sms_point_of_contact = 
      if (Map.has_key?(changes, :phone)) do  
          if (changes[:phone] == nil) do
            false
          else
            true
          end
      else
        if (user.phone == nil) do
          false
        else
          true
        end
    end

    email_point_of_contact = 
      if (Map.has_key?(changes, :email)) do
        if (changes[:email] == nil) do
          false
        else
          true
        end
      else
        if (user.email == nil) do
          false
        else
          true
        end
    end

    app_point_of_contact = 
      if (Map.has_key?(changes, :apikey)) do
        if (changes[:apikey] == nil) do
          false
        else
          true
        end
      else
        if (user.apikey == nil) do
          false
        else
          true
        end
    end

    if (email_point_of_contact == false and sms_point_of_contact == false and app_point_of_contact == false) do
      add_error(changeset, :email, "At least one field between sms, email or apikey cannot be blank")
    else
      changeset
    end
  end

  defp chosen_services_contain_point_of_contact(%Ecto.Changeset{} = changeset) do
    user = changeset.data
    changes = changeset.changes

    sms_enabled = 
      if (Map.has_key?(changes, :sms_enabled)) do  
        changes[:sms_enabled]
      else
        user.sms_enabled
    end

    email_enabled = 
      if (Map.has_key?(changes, :email_enabled)) do  
        changes[:email_enabled]
      else
       user.email_enabled
    end

    app_enabled = 
      if (Map.has_key?(changes, :app_enabled)) do  
        changes[:app_enabled]
      else
       user.app_enabled
    end

    sms_point_of_contact = 
      if (Map.has_key?(changes, :phone)) do  
          if (changes[:phone] == nil) do
            false
          else
            true
          end
      else
        if (user.phone == nil) do
          false
        else
          true
        end
    end

    email_point_of_contact = 
      if (Map.has_key?(changes, :email)) do
        if (changes[:email] == nil) do
          false
        else
          true
        end
      else
        if (user.email == nil) do
          false
        else
          true
        end
    end

    app_point_of_contact = 
      if (Map.has_key?(changes, :apikey)) do
        if (changes[:apikey] == nil) do
          false
        else
          true
        end
      else
        if (user.apikey == nil) do
          false
        else
          true
        end
    end

    if (sms_enabled and !sms_point_of_contact) do
      add_error(changeset, :sms_enabled, "SMS is enabled but there is no phone contact")
    else
      if (email_enabled and !email_point_of_contact) do
        add_error(changeset, :email_enabled, "E-mail is enabled but there is no e-mail contact")
      else
        if (app_enabled and !app_point_of_contact) do
          add_error(changeset, :app_enabled, "App is enabled but there is no API Key")
        else 
          changeset
        end
      end
    end

  end

end
