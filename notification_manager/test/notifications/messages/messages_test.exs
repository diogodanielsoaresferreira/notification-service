defmodule Notifications.MessagesTest do
  use Notifications.DataCase

  alias Notifications.Messages

  describe "notifications" do
    alias Notifications.Messages.Notification

    @valid_attrs %{app: true, content: "some content", email: true, sms: true, timestamp: ~N[2010-04-17 14:00:00.000000], userID: "7488a646-e31f-11e4-aace-600308960662"}
    @update_attrs %{app: false, content: "some updated content", email: false, sms: false, timestamp: ~N[2011-05-18 15:01:01.000000], userID: "7488a646-e31f-11e4-aace-600308960668"}
    @invalid_attrs %{app: nil, content: nil, email: nil, sms: nil, timestamp: nil, userID: nil}

    def notification_fixture(attrs \\ %{}) do
      {:ok, notification} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Messages.create_notification()

      notification
    end

    test "list_notifications/0 returns all notifications" do
      notification = notification_fixture()
      assert Messages.list_notifications() == [notification]
    end

    test "get_notification!/1 returns the notification with given id" do
      notification = notification_fixture()
      assert Messages.get_notification!(notification.id) == notification
    end

    test "create_notification/1 with valid data creates a notification" do
      assert {:ok, %Notification{} = notification} = Messages.create_notification(@valid_attrs)
      assert notification.app == true
      assert notification.content == "some content"
      assert notification.email == true
      assert notification.sms == true
      assert notification.timestamp == ~N[2010-04-17 14:00:00.000000]
      assert notification.userID == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_notification/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_notification(@invalid_attrs)
    end

    test "update_notification/2 with valid data updates the notification" do
      notification = notification_fixture()
      assert {:ok, notification} = Messages.update_notification(notification, @update_attrs)
      assert %Notification{} = notification
      assert notification.app == false
      assert notification.content == "some updated content"
      assert notification.email == false
      assert notification.sms == false
      assert notification.timestamp == ~N[2011-05-18 15:01:01.000000]
      assert notification.userID == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_notification/2 with invalid data returns error changeset" do
      notification = notification_fixture()
      assert {:error, %Ecto.Changeset{}} = Messages.update_notification(notification, @invalid_attrs)
      assert notification == Messages.get_notification!(notification.id)
    end

    test "delete_notification/1 deletes the notification" do
      notification = notification_fixture()
      assert {:ok, %Notification{}} = Messages.delete_notification(notification)
      assert_raise Ecto.NoResultsError, fn -> Messages.get_notification!(notification.id) end
    end

    test "change_notification/1 returns a notification changeset" do
      notification = notification_fixture()
      assert %Ecto.Changeset{} = Messages.change_notification(notification)
    end
  end

  describe "notifications" do
    alias Notifications.Messages.Notification

    @valid_attrs %{app: true, content: "some content", email: true, id: "7488a646-e31f-11e4-aace-600308960662", sms: true, timestamp: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{app: false, content: "some updated content", email: false, id: "7488a646-e31f-11e4-aace-600308960668", sms: false, timestamp: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{app: nil, content: nil, email: nil, id: nil, sms: nil, timestamp: nil}

    def notification_fixture(attrs \\ %{}) do
      {:ok, notification} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Messages.create_notification()

      notification
    end

    test "list_notifications/0 returns all notifications" do
      notification = notification_fixture()
      assert Messages.list_notifications() == [notification]
    end

    test "get_notification!/1 returns the notification with given id" do
      notification = notification_fixture()
      assert Messages.get_notification!(notification.id) == notification
    end

    test "create_notification/1 with valid data creates a notification" do
      assert {:ok, %Notification{} = notification} = Messages.create_notification(@valid_attrs)
      assert notification.app == true
      assert notification.content == "some content"
      assert notification.email == true
      assert notification.id == "7488a646-e31f-11e4-aace-600308960662"
      assert notification.sms == true
      assert notification.timestamp == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_notification/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_notification(@invalid_attrs)
    end

    test "update_notification/2 with valid data updates the notification" do
      notification = notification_fixture()
      assert {:ok, notification} = Messages.update_notification(notification, @update_attrs)
      assert %Notification{} = notification
      assert notification.app == false
      assert notification.content == "some updated content"
      assert notification.email == false
      assert notification.id == "7488a646-e31f-11e4-aace-600308960668"
      assert notification.sms == false
      assert notification.timestamp == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_notification/2 with invalid data returns error changeset" do
      notification = notification_fixture()
      assert {:error, %Ecto.Changeset{}} = Messages.update_notification(notification, @invalid_attrs)
      assert notification == Messages.get_notification!(notification.id)
    end

    test "delete_notification/1 deletes the notification" do
      notification = notification_fixture()
      assert {:ok, %Notification{}} = Messages.delete_notification(notification)
      assert_raise Ecto.NoResultsError, fn -> Messages.get_notification!(notification.id) end
    end

    test "change_notification/1 returns a notification changeset" do
      notification = notification_fixture()
      assert %Ecto.Changeset{} = Messages.change_notification(notification)
    end
  end

  describe "notifications" do
    alias Notifications.Messages.Notification

    @valid_attrs %{app: true, content: "some content", email: true, notificationid: "7488a646-e31f-11e4-aace-600308960662", sms: true, timestamp: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{app: false, content: "some updated content", email: false, notificationid: "7488a646-e31f-11e4-aace-600308960668", sms: false, timestamp: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{app: nil, content: nil, email: nil, notificationid: nil, sms: nil, timestamp: nil}

    def notification_fixture(attrs \\ %{}) do
      {:ok, notification} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Messages.create_notification()

      notification
    end

    test "list_notifications/0 returns all notifications" do
      notification = notification_fixture()
      assert Messages.list_notifications() == [notification]
    end

    test "get_notification!/1 returns the notification with given id" do
      notification = notification_fixture()
      assert Messages.get_notification!(notification.id) == notification
    end

    test "create_notification/1 with valid data creates a notification" do
      assert {:ok, %Notification{} = notification} = Messages.create_notification(@valid_attrs)
      assert notification.app == true
      assert notification.content == "some content"
      assert notification.email == true
      assert notification.notificationid == "7488a646-e31f-11e4-aace-600308960662"
      assert notification.sms == true
      assert notification.timestamp == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_notification/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_notification(@invalid_attrs)
    end

    test "update_notification/2 with valid data updates the notification" do
      notification = notification_fixture()
      assert {:ok, notification} = Messages.update_notification(notification, @update_attrs)
      assert %Notification{} = notification
      assert notification.app == false
      assert notification.content == "some updated content"
      assert notification.email == false
      assert notification.notificationid == "7488a646-e31f-11e4-aace-600308960668"
      assert notification.sms == false
      assert notification.timestamp == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_notification/2 with invalid data returns error changeset" do
      notification = notification_fixture()
      assert {:error, %Ecto.Changeset{}} = Messages.update_notification(notification, @invalid_attrs)
      assert notification == Messages.get_notification!(notification.id)
    end

    test "delete_notification/1 deletes the notification" do
      notification = notification_fixture()
      assert {:ok, %Notification{}} = Messages.delete_notification(notification)
      assert_raise Ecto.NoResultsError, fn -> Messages.get_notification!(notification.id) end
    end

    test "change_notification/1 returns a notification changeset" do
      notification = notification_fixture()
      assert %Ecto.Changeset{} = Messages.change_notification(notification)
    end
  end
end
