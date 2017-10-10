defmodule Escala.CMS.QuestionOptionTest do
  use Escala.DataCase
  import Escala.Factory
  alias Escala.CMS

  describe "create_question_option" do
    test "with valid attributes returns new question option" do
      question = insert(:question, input_type: build(:input_type, has_option: true))
      option_choice = insert(:option_choice)

      attrs = %{question_id: question.id, option_choice_id: option_choice.id}
      assert {:ok, _question_option} = CMS.create_question_option(attrs)
    end

    test "returns error when question input type accept no option" do
      # question factory by default creates input type with has_option: false
      question = insert(:question)
      option_choice = insert(:option_choice)

      attrs = %{question_id: question.id, option_choice_id: option_choice.id}
      assert {:error, changeset} = CMS.create_question_option(attrs)
      assert errors_on(changeset).question_id == ["can't have option"]
    end

    test "requires question_id" do
      assert {:error, changeset} = CMS.create_question_option(%{})
      assert errors_on(changeset).question_id == ["can't be blank"]
    end

    test "requires valid question_id" do
      assert {:error, changeset} = CMS.create_question_option(%{question_id: 1})
      assert errors_on(changeset).question_id == ["is invalid"]
    end

    test "requires option_choice_id" do
      assert {:error, changeset} = CMS.create_question_option(%{})
      assert errors_on(changeset).option_choice_id == ["can't be blank"]
    end

    test "requires valid option_choice_id" do
      assert {:error, changeset} = CMS.create_question_option(%{option_choice_id: 1})
      assert errors_on(changeset).option_choice_id == ["is invalid"]
    end
  end
end
