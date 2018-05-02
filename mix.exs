defmodule ExRLP.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_rlp,
      version: "0.3.0",
      elixir: "~> 1.6",
      description: "Ethereum's Recursive Length Prefix (RLP) encoding",
      package: [
        maintainers: ["Ayrat Badykov", "Geoffrey Hayes"],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/exthereum/ex_rlp"}
      ],
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [ignore_warnings: ".dialyzer.ignore-warnings"],
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:credo, "~> 0.9.1", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:poison, "~> 3.1.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
