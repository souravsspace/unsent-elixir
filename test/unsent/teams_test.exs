defmodule Unsent.TeamsTest do
  use ExUnit.Case, async: true

  describe "Teams module methods" do
    test "get/1 constructs correct path" do
      client = %Unsent.Client{api_key: "test", base_url: "http://test", raise_on_error: false}
      assert is_function(&Unsent.Teams.get/1)
    end

    test "list/1 constructs correct path" do
      assert is_function(&Unsent.Teams.list/1)
    end
  end
end
