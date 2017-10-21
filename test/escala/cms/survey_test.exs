defmodule Escala.CMS.SurveyTest do
  use Escala.DataCase
  import Escala.Factory
  alias Escala.CMS

  def survey_fixture(attrs \\ %{}) do
    insert(:survey, attrs)
  end

  describe "list surveys" do
    test "returns all surveys" do
      [_survey1, _survey2] = insert_pair(:survey)

      assert CMS.list_surveys() |> length == 2
    end
  end

  describe "get_user" do
    test "returns user with valid id" do
      survey = insert(:survey)

      get_user = CMS.get_survey(survey.id)

      assert get_user.id == survey.id
    end

    test "returns nil with invalid id" do
      assert nil == CMS.get_survey(1)
    end
  end

  describe "create_survey" do
    test "with valid attribute returns new survey" do
      user = insert(:account_user)

      assert {:ok, user} = CMS.create_survey(%{name: "demo survey", user_id: user.id})
      assert user.name == "demo survey"
    end

    test "requires name" do
      assert {:error, changeset} = CMS.create_survey(%{})
      assert errors_on(changeset).name == ["can't be blank"]
    end

    test "requires user_id" do
      assert {:error, changeset} = CMS.create_survey(%{name: "demo survey"})
      assert errors_on(changeset).user_id == ["can't be blank"]
    end

    test "requires valid user_id" do
      assert {:error, changeset} = CMS.create_survey(%{name: "demo survey", user_id: 1})
      assert errors_on(changeset).user_id == ["is invalid"]
    end
  end

  describe "update_survey" do
    test "with valid attrs returns updates survey" do
      survey = insert(:survey)

      assert {:ok, u_survey} = CMS.update_survey(survey, %{name: "Updated survey"})
      assert u_survey.name == "Updated survey"
    end
  end
end
