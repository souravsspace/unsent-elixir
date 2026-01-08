defmodule Unsent.SettingsTest do
  use ExUnit.Case, async: true

  describe "Settings module methods" do
    test "get/1 method exists" do
      assert is_function(&Unsent.Settings.get/1)
    end
  end
end
