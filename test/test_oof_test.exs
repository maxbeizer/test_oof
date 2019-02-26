defmodule TestOofTest do
  use ExUnit.Case
  doctest TestOof

  test "greets the world" do
    TestOof.ensure_test_files_are_exs!(File.cwd! <> "/oof_test")
    assert true
  end
end
