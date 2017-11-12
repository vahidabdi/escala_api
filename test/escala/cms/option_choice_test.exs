defmodule Escala.CMS.OptionChoiceTest do
  use Escala.DataCase
  import Escala.Factory
  alias Escala.CMS

  describe "create_option_choices" do
    test "with valid attributes returns new option choice" do
      q = insert(:question)
      attrs = %{option_choice_name: "Very good", option_choice_value: "10", question_id: q.id}
      assert {:ok, _option_choice} = CMS.create_option_choice(attrs)
    end

    test "requires option_choice_name" do
      assert {:error, changeset} = CMS.create_option_choice(%{})
      assert errors_on(changeset).option_choice_name == ["can't be blank"]
    end

    test "requires option_choice_value" do
      assert {:error, changeset} = CMS.create_option_choice(%{})
      assert errors_on(changeset).option_choice_value == ["can't be blank"]
    end

    test "requires question_id" do
      assert {:error, changeset} = CMS.create_option_choice(%{})
      assert errors_on(changeset).question_id == ["can't be blank"]
    end

    test "requires valid question_id" do
      assert {:error, changeset} = CMS.create_option_choice(%{question_id: 1})
      assert errors_on(changeset).question_id == ["is invalid"]
    end
  end
end
