defmodule WxElixir.Macro.DefineSpec do
  use ESpec

  describe "load_const" do
    subject do: {Const.ok1(), Const.ok2(), Const.ok3()}
    it do: is_expected() |> to(match_pattern {5100, 5100, 5100})
  end
end
