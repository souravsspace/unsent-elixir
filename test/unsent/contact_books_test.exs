defmodule Unsent.ContactBooksTest do
  use ExUnit.Case, async: true

  describe "ContactBooks module methods" do
    test "list/1 method exists" do
      assert is_function(&Unsent.ContactBooks.list/1)
    end

    test "create/2 method exists" do
      assert is_function(&Unsent.ContactBooks.create/2)
    end

    test "get/2 method exists" do
      assert is_function(&Unsent.ContactBooks.get/2)
    end

    test "update/3 method exists" do
      assert is_function(&Unsent.ContactBooks.update/3)
    end

    test "delete/2 method exists" do
      assert is_function(&Unsent.ContactBooks.delete/2)
    end
  end
end
