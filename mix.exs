defmodule TestOof.MixProject do
  use Mix.Project

  def project do
    [
      app: :test_oof,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Never miss the compiler warning for _test.ex files again.",
      package: [
        name: "test_oof",
        files: ~w(lib .formatter.exs mix.exs README* LICENSE* CHANGELOG*),
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/maxbeizer/test_oof"}
      ],
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
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end
end
