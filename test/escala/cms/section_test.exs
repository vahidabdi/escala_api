defmodule Escala.CMS.SectionTest do
  use Escala.DataCase
  import Escala.Factory
  alias Escala.CMS

  def section_fixture(attrs \\ %{}) do
    insert(:section, attrs)
  end

  describe "list survey sections" do
    test "returns all sections of survey" do
      survey = build(:survey) |> insert |> with_sections

      [section0, section1] = CMS.list_sections(survey.id)
      assert section0.header == "header0"
      assert section1.header == "header1"
    end

    test "returns empty list when there is no section" do
      survey = insert(:survey)

      assert [] == CMS.list_sections(survey.id)
    end
  end
end
