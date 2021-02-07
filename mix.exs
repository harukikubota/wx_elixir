defmodule WxElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :wx_elixir,
      version: "0.0.1",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      preferred_cli_env: [espec: :test],
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:espec, "~> 1.8.3", only: :test},
      {:wx_utils, "~> 0.0.2"}
    ]
  end
end
