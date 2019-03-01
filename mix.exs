defmodule TestOof.MixProject do
  use Mix.Project

  @version "0.1.0"

  def(project) do
    [
      app: :test_oof,
      version: @version,
      elixir: "~> 1.7 or ~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Never miss the compiler warning for _test.ex files again.",
      package: package(),
      source_url: "https://github.com/maxbeizer/test_oof",
      homepage_url: "https://github.com/maxbeizer/test_oof"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      name: "test_oof",
      files: ~w(lib .formatter.exs mix.exs README* LICENSE* CHANGELOG*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/maxbeizer/test_oof"}
    ]
  end
end
