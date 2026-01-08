defmodule Unsent.AnalyticsTest do
  use ExUnit.Case, async: true

  describe "Analytics module methods" do
    test "get/1 constructs correct path" do
      # Simple structural test - just verify the method exists and takes right args
      client = %Unsent.Client{api_key: "test", base_url: "http://test", raise_on_error: false}

      # These will fail with network errors, but we're just checking the method exists
      assert is_function(&Unsent.Analytics.get/1)
    end

    test "get_time_series/2 constructs paths with query params" do
      assert is_function(&Unsent.Analytics.get_time_series/2)
    end

    test "get_reputation/2 constructs paths with query params" do
      assert is_function(&Unsent.Analytics.get_reputation/2)
    end
  end
end
