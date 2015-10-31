defmodule Spell.Mixfile do
  use Mix.Project

  def project do
    [app: :spell,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Spell, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger_file_backend,
       :logger, :phoenix_ecto, :postgrex, :exredis]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 1.0.2"},
     {:phoenix_ecto, "~> 1.2.0"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 2.2.0"},
     {:phoenix_live_reload, "~> 1.0.1", only: :dev},
     {:cowboy, "~> 1.0"},
     {:exredis, ">= 0.2.0"},
     {:poison, github: "devinus/poison", branch: "master", override: true},
     {:bureaucrat, "0.0.4"},
     {:logger_file_backend, "0.0.5"},
     {:exrm, "~> 0.19.6"}]
  end
end
