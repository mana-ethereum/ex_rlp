defmodule ExRLP.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_rlp,
      version: "0.5.3",
      elixir: "~> 1.7",
      description: "Ethereum's Recursive Length Prefix (RLP) encoding",
      package: [
        maintainers: ["Ayrat Badykov", "Geoffrey Hayes"],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/mana-ethereum/ex_rlp"}
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
      {:credo, "~> 0.10.2", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:poison, "~> 4.0.1", only: [:dev, :test], runtime: false},
      {:propcheck, "~> 1.1", only: [:test]}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
