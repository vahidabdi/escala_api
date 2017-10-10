defmodule Escala.CMS.InputTypeTest do
  use Escala.DataCase
  import Escala.Factory
  alias Escala.CMS

  describe "create_input_type" do
    test "with valid attributes returns new input_type" do
      attrs = %{name: "short text", has_option: false}
      assert {:ok, _input_type} = CMS.create_input_type(attrs)
    end

    test "requires name" do
      assert {:error, changeset} = CMS.create_input_type(%{})
      assert errors_on(changeset).name == ["can't be blank"]
    end

  end

  test "with duplicate name returns error" do
    attrs = %{name: "short text", has_option: false}
    assert {:ok, _input_type} = CMS.create_input_type(attrs)
    assert {:error, changeset} = CMS.create_input_type(attrs)
    assert errors_on(changeset).name == ["has already been taken"]
  end

  test "requires has_option" do
    assert {:error, changeset} = CMS.create_input_type(%{})
    assert errors_on(changeset).has_option == ["can't be blank"]
  end

end
