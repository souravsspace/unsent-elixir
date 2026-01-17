defmodule Unsent.EmailsTest do
  use ExUnit.Case, async: true

  describe "Emails module methods" do
    test "send/3 and create/3 methods exist" do
      assert is_function(&Unsent.Emails.send/3)
      assert is_function(&Unsent.Emails.create/3)
    end

    test "batch/3 method exists" do
      assert is_function(&Unsent.Emails.batch/3)
    end

    test "list/2 method exists with query support" do
      assert is_function(&Unsent.Emails.list/2)
    end

    test "get_bounces/2 method exists" do
      assert is_function(&Unsent.Emails.get_bounces/2)
    end

    test "get_complaints/2 method exists" do
      assert is_function(&Unsent.Emails.get_complaints/2)
    end

    test "get_unsubscribes/2 method exists" do
      assert is_function(&Unsent.Emails.get_unsubscribes/2)
    end

    test "get/2 method exists" do
      assert is_function(&Unsent.Emails.get/2)
    end

    test "update/3 method exists" do
      assert is_function(&Unsent.Emails.update/3)
    end

    test "cancel/2 method exists" do
      assert is_function(&Unsent.Emails.cancel/2)
    end

    test "get_events/3 method exists" do
      assert is_function(&Unsent.Emails.get_events/3)
    end
  end
end
