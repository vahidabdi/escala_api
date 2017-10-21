defmodule Escala.CMS.OptionGroupTest do
  use Escala.DataCase
  import Escala.Factory
  alias Escala.CMS

  describe "create option group" do
    test "with valid attributes returns new survey" do
      user = insert(:account_user)

      attrs = %{name: "Rate 1-5", user_id: user.id}
      assert {:ok, option_group} = CMS.create_option_group(attrs)
      assert option_group.name == "Rate 1-5"
    end

    test "requires name" do
      assert {:error, changeset} = CMS.create_option_group(%{})
      assert errors_on(changeset).name == ["can't be blank"]
    end

    test "requires user_id" do
      assert {:error, changeset} = CMS.create_option_group(%{name: "Rate 1-5"})
      assert errors_on(changeset).user_id == ["can't be blank"]
    end

    test "requires valid user_id" do
      assert {:error, changeset} = CMS.create_option_group(%{name: "Rate 1-5", user_id: 1})
      assert errors_on(changeset).user_id == ["is invalid"]
    end
  end
end
