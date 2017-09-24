defmodule Escala.Accounts.UserTest do
  use Escala.DataCase
  import Escala.Factory
  alias Escala.Accounts
  alias Escala.Accounts.User, warn: false

  @valid_user %{
    email: "user@example.com",
    username: "username",
  }

  def user_fixture(attrs \\ %{}) do
    insert(:account_user, attrs)
  end

  def create_user(attrs \\ %{}) do
    attrs
    |> Enum.into(@valid_user)
    |> Accounts.create_user()
  end

  describe "list_users" do
    test "returns all users" do
      [user1, user2] = insert_pair(:account_user)

      assert Accounts.list_users == [user1, user2]
    end
  end

  describe "get_user" do
    test "returns user with valid id" do
      user = user_fixture()

      get_user = Accounts.get_user(user.id)

      assert get_user.id == user.id
    end

    test "returns nil with invalid id" do
      assert nil == Accounts.get_user(1)
    end
  end

  describe "create_user" do
    test "with valid attribute returns new user" do
      user = user_fixture(email: "user@example.com")

      assert user.email == "user@example.com"
    end

    test "requires email" do
      assert {:error, changeset} = create_user(%{email: nil})
      assert errors_on(changeset).email == ["can't be blank"]
    end

    test "with invalid email format returns error" do
      assert {:error, changeset} = create_user(%{email: "invalid@email"})
      assert errors_on(changeset).email == ["has invalid format"]
    end

    test "with duplicate email returns error" do
      user_fixture(email: @valid_user.email)

      assert {:error, changeset} = create_user(@valid_user)
      assert errors_on(changeset).email == ["has already been taken"]
    end
  end

  describe "update_user" do
    test "updates username, first_name, last_name but not email" do
      user = user_fixture(%{email: "email@example.com", username: "username"})

      params =
        %{
          email: "new_email@domain.com",
          username: "new_user",
          first_name: "vahid",
          last_name: "abdi"
        }
      {:ok, updated_user} = Accounts.update_user(user, params)
      assert updated_user.username == "new_user"
      assert updated_user.first_name == "vahid"
      assert updated_user.last_name == "abdi"
      assert updated_user.email == "email@example.com" # Doesn't change email
    end
  end

  describe "find_or_create_user" do
    test "creates a new user when user not found" do
      params = %{email: "new_email@domain.com"}

      {:ok, user} = Accounts.find_or_create_user(params)
      assert user.email == "new_email@domain.com"
    end

    test "get a user from db when user exist" do
      assert {:ok, user} = Accounts.find_or_create_user(%{email: "user@example.com"})
      assert {:ok, find_user} = Accounts.find_or_create_user(%{email: "user@example.com"})

      assert user.id == find_user.id
    end
  end
end
