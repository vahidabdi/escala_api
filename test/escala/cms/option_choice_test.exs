defmodule Escala.CMS.OptionChoiceTest do
  use Escala.DataCase
  import Escala.Factory
  alias Escala.CMS

  describe "create_option_choices" do
    test "with valid attributes returns new option choice" do
      o = insert(:option_group, user: build(:account_user))
      attrs = %{option_choice_name: "Very good", option_choice_value: "10", option_group_id: o.id}
      assert {:ok, _option_choice} = CMS.create_option_choice(attrs)
    end

    test "requires option_choice_name" do
      assert {:error, changeset} = CMS.create_option_choice(%{})
      assert errors_on(changeset).option_choice_name == ["can't be blank"]
    end

    test "requires option_group_id" do
      assert {:error, changeset} = CMS.create_option_choice(%{})
      assert errors_on(changeset).option_group_id == ["can't be blank"]
    end

    test "requires valid option_group_id" do
      assert {:error, changeset} = CMS.create_option_choice(%{option_group_id: 1})
      assert errors_on(changeset).option_group_id == ["is invalid"]
    end
  end
end
