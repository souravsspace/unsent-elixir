defmodule Unsent.TemplatesTest do
  use ExUnit.Case, async: true

  describe "Templates module methods" do
    test "list/1 method exists" do
      assert is_function(&Unsent.Templates.list/1)
    end

    test "create/2 method exists" do
      assert is_function(&Unsent.Templates.create/2)
    end

    test "get/2 method exists" do
      assert is_function(&Unsent.Templates.get/2)
    end

    test "update/3 method exists" do
      assert is_function(&Unsent.Templates.update/3)
    end

    test "delete/2 method exists" do
      assert is_function(&Unsent.Templates.delete/2)
    end
  end
end
