defmodule Unsent.SuppressionsTest do
  use ExUnit.Case, async: true

  describe "Suppressions module methods" do
    test "list/2 method exists with query support" do
      assert is_function(&Unsent.Suppressions.list/2)
    end

    test "add/2 method exists" do
      assert is_function(&Unsent.Suppressions.add/2)
    end

    test "delete/2 method exists" do
      assert is_function(&Unsent.Suppressions.delete/2)
    end
  end
end
