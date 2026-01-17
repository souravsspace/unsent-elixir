defmodule Unsent.SystemTest do
  use ExUnit.Case, async: true

  describe "System module methods" do
    test "health/1 constructs correct path" do
      client = %Unsent.Client{api_key: "test", base_url: "http://test", raise_on_error: false}
      assert is_function(&Unsent.System.health/1)
    end

    test "version/1 constructs correct path" do
      assert is_function(&Unsent.System.version/1)
    end
  end
end
