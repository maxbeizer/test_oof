defmodule TestOofTest do
  use ExUnit.Case, async: true
  doctest TestOof

  alias TestOof.WrongFileExtensionError

  describe "ensure_test_files_are_exs/1" do
    test "happy path: all test files are exs" do
      result = TestOof.ensure_test_files_are_exs!()
      assert :ok == result
    end

    test "with errors: raises" do
      assert_raise WrongFileExtensionError, ~r/The following test files/, fn ->
        TestOof.ensure_test_files_are_exs!(File.cwd!() <> "/oof_test")
      end
    end
  end
end
