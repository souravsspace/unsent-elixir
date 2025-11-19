defmodule UnsentTest do
  use ExUnit.Case
  doctest Unsent

  test "greets the world" do
    assert Unsent.hello() == :world
  end
end
