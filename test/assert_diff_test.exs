defmodule AssertDiffTest do
  use ExUnit.Case

  import AssertDiff

  test "assert_diff" do
    assert_diff "Pam Param\n" == "Pum Purum"
  end
end
