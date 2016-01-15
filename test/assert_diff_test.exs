defmodule AssertDiffTest do
  use ExUnit.Case

  import AssertDiff

  test "assert_diff failed" do
    assert_diff "Pam Param\n" == "Pum Purum"
  end

  test "assert_diff success" do
    assert_diff "Pam Param" == "Pam Param"
  end
end
