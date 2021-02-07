defmodule Impressions.MixProject do
  use Mix.Project

  def project do
    [
      app: :impressions,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :kaffe],
      mod: {Impressions.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:poison, "~> 3.1"},
      {:redix, ">= 0.0.0"},
      {:kaffe, "~> 1.0"},
      {:retry, "~> 0.14"}
    ]
  end
end
