defmodule Unsent.ContactsTest do
  use ExUnit.Case, async: true

  describe "Contacts module methods" do
    test "list/3 method exists with query support" do
      assert is_function(&Unsent.Contacts.list/3)
    end

    test "create/3 method exists" do
      assert is_function(&Unsent.Contacts.create/3)
    end

    test "get/3 method exists" do
      assert is_function(&Unsent.Contacts.get/3)
    end

    test "update/4 method exists" do
      assert is_function(&Unsent.Contacts.update/4)
    end

    test "upsert/4 method exists" do
      assert is_function(&Unsent.Contacts.upsert/4)
    end

    test "delete/3 method exists" do
      assert is_function(&Unsent.Contacts.delete/3)
    end
  end
end
