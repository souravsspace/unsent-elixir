defmodule UnsentTest do
  use ExUnit.Case
  doctest Unsent

  test "module exists and can create client" do
    assert is_atom(Unsent)
  end
end
