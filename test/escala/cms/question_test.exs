defmodule Escala.CMS.QuestionTest do
  use Escala.DataCase
  import Escala.Factory
  alias Escala.CMS

  setup _context do
    input_type = insert(:input_type)
    section = insert(:section, survey: build(:survey))
    {:ok, %{input_type: input_type, section: section}}
  end

  describe "create_question" do
    test "with valid attributes returns new question", %{section: section, input_type: input_type} do
      attrs =
        %{
          question_text: "what's your name?",
          section_id: section.id,
          input_type_id: input_type.id
        }
      assert {:ok, _question} = CMS.create_question(attrs)
    end

    test "requires question_text", %{section: section, input_type: input_type} do
      attrs =
        %{
          section_id: section.id,
          input_type_id: input_type.id
        }
      assert {:error, changeset} = CMS.create_question(attrs)
      assert errors_on(changeset).question_text == ["can't be blank"]
    end

    test "requires input_type_id", %{section: section} do
      attrs =
        %{
          question_text: "what's your name?",
          section_id: section.id
        }
      assert {:error, changeset} = CMS.create_question(attrs)
      assert errors_on(changeset).input_type_id == ["can't be blank"]
    end

    test "requires valid input_type_id", %{section: section} do
      attrs =
        %{
          question_text: "what's your name?",
          section_id: section.id,
          input_type_id: 1
        }
      assert {:error, changeset} = CMS.create_question(attrs)
      assert errors_on(changeset).input_type_id == ["is invalid"]
    end

    test "requires section_id", %{input_type: input_type} do
      attrs =
        %{
          question_text: "what's your name?",
          input_type_id: input_type.id
        }
      assert {:error, changeset} = CMS.create_question(attrs)
      assert errors_on(changeset).section_id == ["can't be blank"]
    end

    test "requires valid section_id", %{input_type: input_type} do
      attrs =
        %{
          question_text: "what's your name?",
          section_id: 1,
          input_type_id: input_type.id
        }
      assert {:error, changeset} = CMS.create_question(attrs)
      assert errors_on(changeset).section_id == ["is invalid"]
    end
  end
end
