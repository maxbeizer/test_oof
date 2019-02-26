defmodule TestOof do
  @moduledoc """
  Documentation for TestOof.
  """

  @elixir_script_extension ".exs"

  def ensure_test_files_are_exs!(dir \\ File.cwd!() <> "/test") do
    result =
      dir
      |> fetch_all_test_files()
      |> Enum.filter(&test_file?/1)
      |> Enum.filter(&non_elixir_script_extension?/1)

    IO.inspect(result)
  end

  defp fetch_all_test_files(dir) do
    expand(File.ls(dir), dir)
  end

  defp expand({:ok, files}, path) do
    Enum.flat_map(files, &fetch_all_test_files("#{path}/#{&1}"))
  end

  defp expand({:error, _}, path), do: [path]

  defp test_file?(path) do
    path
    |> Path.rootname()
    |> String.ends_with?("_test")
  end

  defp non_elixir_script_extension?(path) do
    Path.extname(path) != @elixir_script_extension
  end
end
