defmodule TestOof do
  @moduledoc """
  TestOof: A tiny test helper tool to make sure all your test files run.

  ## Why
  I'm an idiot. As an idiot, I often will write tests that I think are great
  and the whole suite passes and I feel great about myself. Only
  later—sometimes much later— do I notice the compiler warning that one of my
  beautiful tests has the `.ex` extenion and not the `.exs` extension that
  ExUnit requires to run the test.

  This package is an attempt to remove that rake I tend to step on.

  ## How it works
  TestOof assumes that all files in your test directory (the location of
  which you can override) that end in `_test` are indeed ExUnit test files.
  TestOof gathers files matching that criteria and filters that list down to
  files whose extension is anything other than `.exs`. If there are any files
  left after filter, TestOof raises and lists all offenders.

  * Could it be more efficient? Certainly.
  * Will it stop me from making the mistake of assuming test are running when
  the actually aren't? Possibly
  """

  @elixir_script_extension ".exs"
  @type test_dir :: String.t()
  # Maybe add regex below?
  @type ignore :: String.t()
  @type ignores :: [ignore]
  @type option :: {:test_dir, test_dir()} | {:ignore, ignores}
  @type t :: %__MODULE__{test_dir: test_dir(), ignore: ignores()}

  defstruct(test_dir: File.cwd!() <> "/test", ignore: [])

  defmodule WrongFileExtensionError do
    defexception [:message]
    @message "The following test files did not have the .exs extension:\n"

    @impl true
    def exception(files) do
      message = @message <> Enum.join(files, ",\n")

      %WrongFileExtensionError{message: message}
    end
  end

  @doc """
  Given a location of test files, recursively collect all files whose name
  ends with `_test` and then filter out all files that end with `.exs`. If
  any files remain, raise the WrongFileExtensionError exception.
  """
  @spec ensure_test_files_are_exs!([option]) :: :ok | no_return()
  def ensure_test_files_are_exs!(raw_config \\ []) do
    config = do_config(raw_config)

    result =
      config
      |> fetch_all_test_files()
      |> Enum.filter(&attended?(&1, config))
      |> Enum.filter(&test_file?/1)
      |> Enum.filter(&non_elixir_script_extension?/1)

    case result do
      [] ->
        :ok

      oofs ->
        raise WrongFileExtensionError, oofs
    end
  end

  defp fetch_all_test_files(%{test_dir: test_dir}) do
    expand(File.ls(test_dir), test_dir)
  end

  defp expand({:ok, files}, path) do
    Enum.flat_map(files, &fetch_all_test_files(%{test_dir: "#{path}/#{&1}"}))
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

  defp attended?(_path, %{ignore: []}), do: true

  defp attended?(path, %{ignore: paths}) do
    do_not_ignore?(path, paths, true)
  end

  defp do_not_ignore?(_path, _paths, false), do: false
  defp do_not_ignore?(_path, [], result), do: result

  defp do_not_ignore?(path, [head | tail], _result) do
    do_not_ignore?(path, tail, path =~ head)
  end

  defp do_config([]), do: %__MODULE__{}
  defp do_config(config), do: do_config(config, %__MODULE__{})
  defp do_config([], config), do: config

  defp do_config([head | tail], config) do
    do_config(tail, struct(config, [head]))
  end
end
