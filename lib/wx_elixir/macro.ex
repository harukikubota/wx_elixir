defmodule WxElixir.Macro do
  defmacro __using__(_) do
    quote do
      use WxElixir.Macro.Define
    end
  end
end
