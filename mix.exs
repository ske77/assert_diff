defmodule AssertDiff.Mixfile do
  use Mix.Project

  def project do
    [app: :assert_diff,
     version: "0.0.3",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description,
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  defp deps do
    []
  end

  defp description do
    """
    assert_diff which fallbacks to git diff
    """
  end

  defp package do
    [
     files: ["lib", "mix.exs", "README*"],
     maintainers: ["ske77"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/ske77/assert_diff"}
    ]
  end
end
