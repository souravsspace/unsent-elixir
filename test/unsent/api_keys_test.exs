defmodule Unsent.ApiKeysTest do
  use ExUnit.Case, async: true

  describe "ApiKeys module methods" do
    test "list/1 method exists" do
      assert is_function(&Unsent.ApiKeys.list/1)
    end

    test "create/2 method exists" do
      assert is_function(&Unsent.ApiKeys.create/2)
    end

    test "delete/2 method exists" do
      assert is_function(&Unsent.ApiKeys.delete/2)
    end
  end
end
