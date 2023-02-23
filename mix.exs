defmodule ExRLP.Mixfile do
  use Mix.Project

  @source_url "https://github.com/mana-ethereum/ex_rlp"
  @version "0.6.0"

  def project do
    [
      app: :ex_rlp,
      version: @version,
      elixir: "~> 1.7",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      docs: docs(),
      dialyzer: [ignore_warnings: ".dialyzer.ignore-warnings", plt_add_apps: [:jason]],
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev, :test], runtime: false},
      {:jason, "~> 1.3", only: [:dev, :test], runtime: false},
      {:propcheck, "~> 1.4", only: [:test]}
    ]
  end

  defp package do
    [
      description: "Ethereum's Recursive Length Prefix (RLP) encoding",
      maintainers: ["Ayrat Badykov", "Geoffrey Hayes"],
      licenses: ["MIT"],
      links: %{
        "Changelog" => "https://hexdocs.pm/ex_rlp/changelog.html",
        "GitHub" => @source_url
      }
    ]
  end

  defp docs do
    [
      extras: [
        "CHANGELOG.md",
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      formatters: ["html"]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
