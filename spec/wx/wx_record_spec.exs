defmodule WxRecordSpec do
  use ESpec
  use WxElixir

  require Record

  describe "#wx{}" do
    context "initialize" do
      subject do: wx()
      it do: is_expected() |> to(match_pattern {:wx, :undefined, :undefined, :undefined, :undefined})
    end

    context "key_check" do
      subject do: wx(wx()) |> Keyword.keys
      it do: is_expected() |> to(match_pattern [:id, :obj, :userData, :event])
    end

    context "pattern match" do
      subject do: wx(event: _) = wx()
      it do: is_expected() |> Record.is_record() |> to(be_true())
    end
  end
end
