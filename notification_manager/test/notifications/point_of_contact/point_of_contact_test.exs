defmodule Notifications.PointOfContactTest do
  use Notifications.DataCase

  alias Notifications.PointOfContact

  describe "users" do
    alias Notifications.PointOfContact.User

    @valid_attrs %{email: "some email", phone: "some phone"}
    @update_attrs %{email: "some updated email", phone: "some updated phone"}
    @invalid_attrs %{email: nil, phone: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PointOfContact.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert PointOfContact.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert PointOfContact.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = PointOfContact.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.phone == "some phone"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PointOfContact.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = PointOfContact.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.phone == "some updated phone"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = PointOfContact.update_user(user, @invalid_attrs)
      assert user == PointOfContact.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = PointOfContact.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> PointOfContact.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = PointOfContact.change_user(user)
    end
  end

  describe "users" do
    alias Notifications.PointOfContact.User

    @valid_attrs %{email: "some email", id: "7488a646-e31f-11e4-aace-600308960662", phone: "some phone"}
    @update_attrs %{email: "some updated email", id: "7488a646-e31f-11e4-aace-600308960668", phone: "some updated phone"}
    @invalid_attrs %{email: nil, id: nil, phone: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PointOfContact.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert PointOfContact.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert PointOfContact.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = PointOfContact.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.id == "7488a646-e31f-11e4-aace-600308960662"
      assert user.phone == "some phone"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PointOfContact.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = PointOfContact.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.id == "7488a646-e31f-11e4-aace-600308960668"
      assert user.phone == "some updated phone"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = PointOfContact.update_user(user, @invalid_attrs)
      assert user == PointOfContact.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = PointOfContact.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> PointOfContact.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = PointOfContact.change_user(user)
    end
  end

  describe "users" do
    alias Notifications.PointOfContact.User

    @valid_attrs %{email: "some email", phone: "some phone", userid: "7488a646-e31f-11e4-aace-600308960662"}
    @update_attrs %{email: "some updated email", phone: "some updated phone", userid: "7488a646-e31f-11e4-aace-600308960668"}
    @invalid_attrs %{email: nil, phone: nil, userid: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PointOfContact.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert PointOfContact.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert PointOfContact.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = PointOfContact.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.phone == "some phone"
      assert user.userid == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PointOfContact.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = PointOfContact.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.phone == "some updated phone"
      assert user.userid == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = PointOfContact.update_user(user, @invalid_attrs)
      assert user == PointOfContact.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = PointOfContact.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> PointOfContact.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = PointOfContact.change_user(user)
    end
  end
end
