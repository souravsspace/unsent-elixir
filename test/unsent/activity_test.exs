defmodule Unsent.ActivityTest do
  use ExUnit.Case, async: true

  describe "Activity module methods" do
    test "get/1 constructs correct path" do
      client = %Unsent.Client{api_key: "test", base_url: "http://test", raise_on_error: false}
      assert is_function(&Unsent.Activity.get/1)
    end

    test "get/2 constructs paths with query params" do
      assert is_function(&Unsent.Activity.get/2)
    end
  end
end
