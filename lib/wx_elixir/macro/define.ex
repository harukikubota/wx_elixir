defmodule WxElixir.Macro.Define do

  defmacro load_header(files) do
    quote bind_quoted: [files: files] do
      files
      |> Enum.map(fn file ->
        [app | path] = :filename.split(file)
        lib_dir = :code.lib_dir(app)

        Enum.join([lib_dir] ++ path, "/")
      end)
      |> Enum.each(fn path ->
        Record.extract_all(from: path)
        |> Enum.each(fn {record_name, attributes} ->
          Record.defrecord(record_name, attributes)
        end)
      end)
    end
  end

  defmacro __using__(_) do
    quote do
      require Record
      require unquote(__MODULE__)

      unquote(__MODULE__).load_header(['wx/include/wx.hrl', 'wx/src/wxe.hrl'])

      @doc """
      fetch constants by specifying constant_names.

      see `wx_utils/README.md`.
      """
      def const(const_name), do: apply(:wx_const, const_name, [])

      @doc """
      alias for const/1
      """
      def c(const_name), do: const(const_name)

      @doc """
      load the specified constants name into the module.

          load_const(:wxID_OK)
          @wxID_OK # => 5100

          load_const(ok: :wxID_OK)
          @ok # =>5100
      """
      @spec load_const(list()) :: any()
      defmacro load_const(assocs) do
        quote bind_quoted: [assocs: assocs] do
          List.wrap(assocs)
          |> Enum.each(
            fn
              name when is_atom(name) ->
                Module.put_attribute __MODULE__, name, c(name)

              {alias_name, name} ->
                Module.put_attribute __MODULE__, alias_name, c(name)

              err -> raise "require const_name or {name_atom, const_name} -> #{err}"
          end)
        end
      end
    end
  end
end
