defmodule Unsent.CampaignsTest do
  use ExUnit.Case, async: true

  describe "Campaigns module methods" do
    test "list/1 method exists" do
      assert is_function(&Unsent.Campaigns.list/1)
    end

    test "create/2 method exists" do
      assert is_function(&Unsent.Campaigns.create/2)
    end

    test "get/2 method exists" do
      assert is_function(&Unsent.Campaigns.get/2)
    end

    test "schedule/3 method exists" do
      assert is_function(&Unsent.Campaigns.schedule/3)
    end

    test "pause/2 method exists" do
      assert is_function(&Unsent.Campaigns.pause/2)
    end

    test "resume/2 method exists" do
      assert is_function(&Unsent.Campaigns.resume/2)
    end
  end
end
