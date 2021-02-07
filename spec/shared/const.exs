defmodule Const do
  use WxElixir

  load_const([
    :wxID_OK,
    ok: :wxID_OK
  ])

  def ok1, do: @wxID_OK
  def ok2, do: @ok
  def ok3, do: const(:wxID_OK)
end
