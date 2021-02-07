defmodule WxElixir do
  @moduledoc """
  Documentation for `WxElixir`.
  """

  use WxElixir.Macro

  defmacro __using__(_) do
    quote do
      require WxElixir
      import  WxElixir
    end
  end
end
