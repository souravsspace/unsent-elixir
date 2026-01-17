defmodule Unsent.DomainsTest do
  use ExUnit.Case, async: true

  describe "Domains module methods" do
    test "list/1 method exists" do
      assert is_function(&Unsent.Domains.list/1)
    end

    test "create/2 method exists" do
      assert is_function(&Unsent.Domains.create/2)
    end

    test "verify/2 method exists" do
      assert is_function(&Unsent.Domains.verify/2)
    end

    test "get/2 method exists" do
      assert is_function(&Unsent.Domains.get/2)
    end

    test "delete/2 method exists" do
      assert is_function(&Unsent.Domains.delete/2)
    end

    test "get_analytics/3 method exists" do
      assert is_function(&Unsent.Domains.get_analytics/3)
    end

    test "get_stats/3 method exists" do
      assert is_function(&Unsent.Domains.get_stats/3)
    end
  end
end
