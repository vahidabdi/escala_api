defmodule Escala.CMS.QuestionTest do
  use Escala.DataCase
  import Escala.Factory
  alias Escala.CMS

  setup _context do
    input_type = insert(:input_type)
    survey = insert(:survey)
    {:ok, %{input_type: input_type, survey: survey}}
  end

  describe "create_question" do
    test "with valid attributes returns new question", %{survey: survey, input_type: input_type} do
      attrs =
        %{
          question_text: "what's your name?",
          survey_id: survey.id,
          input_type_id: input_type.id,
          position: 1,
        }

      assert {:ok, _question} = CMS.create_question(attrs)
    end

    test "requires question_text", %{survey: survey, input_type: input_type} do
      attrs =
        %{
          survey_id: survey.id,
          input_type_id: input_type.id
        }

      assert {:error, changeset} = CMS.create_question(attrs)
      assert errors_on(changeset).question_text == ["can't be blank"]
    end

    test "requires input_type_id", %{survey: survey} do
      attrs =
        %{
          question_text: "what's your name?",
          survey_id: survey.id
        }

      assert {:error, changeset} = CMS.create_question(attrs)
      assert errors_on(changeset).input_type_id == ["can't be blank"]
    end

    test "requires valid input_type_id", %{survey: survey} do
      attrs =
        %{
          question_text: "what's your name?",
          survey_id: survey.id,
          input_type_id: 1
        }

      assert {:error, changeset} = CMS.create_question(attrs)
      assert errors_on(changeset).input_type_id == ["is invalid"]
    end

    test "requires survey_id", %{input_type: input_type} do
      attrs =
        %{
          question_text: "what's your name?",
          input_type_id: input_type.id
        }

      assert {:error, changeset} = CMS.create_question(attrs)
      assert errors_on(changeset).survey_id == ["can't be blank"]
    end

    test "requires valid survey_id", %{input_type: input_type} do
      attrs =
        %{
          question_text: "what's your name?",
          survey_id: 1,
          input_type_id: input_type.id
        }

      assert {:error, changeset} = CMS.create_question(attrs)
      assert errors_on(changeset).survey_id == ["is invalid"]
    end

    test "requires position", %{input_type: input_type, survey: survey} do
      attrs =
        %{
          question_text: "What's your name?",
          survey_id: survey.id,
          input_type_id: input_type.id,
        }

      assert {:error, changeset} = CMS.create_question(attrs)
      assert errors_on(changeset).position == ["can't be blank"]
    end

    test "requires unique position in survey", %{input_type: input_type, survey: survey} do
      attrs =
        %{
          question_text: "What's your name?",
          survey_id: survey.id,
          input_type_id: input_type.id,
          position: 1
        }

      assert {:ok, _q} = CMS.create_question(attrs)
      assert {:error, changeset} = CMS.create_question(attrs)
      assert errors_on(changeset).position == ["has already been taken"]
    end
  end
end
