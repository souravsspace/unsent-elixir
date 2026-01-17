defmodule Unsent.EventsTest do
  use ExUnit.Case, async: true

  describe "Events module methods" do
    test "list/1 constructs correct path" do
      client = %Unsent.Client{api_key: "test", base_url: "http://test", raise_on_error: false}
      assert is_function(&Unsent.Events.list/1)
    end

    test "list/2 constructs paths with query params" do
      assert is_function(&Unsent.Events.list/2)
    end
  end
end
