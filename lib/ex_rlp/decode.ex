defmodule ExRLP.Decode do
  @moduledoc false

  alias ExRLP.DecodeItem
  @spec decode(binary(), keyword()) :: ExRLP.t() | {ExRLP.t(), binary()} | no_return()
  def decode(item, options \\ [])

  def decode("", _), do: raise(ExRLP.DecodeError)

  def decode(item, options) when is_binary(item) do
    encoding = Keyword.get(options, :encoding, :binary)
    stream = Keyword.get(options, :stream, false)

    item
    |> unencode(encoding)
    |> DecodeItem.decode_item(stream)
  end

  @spec unencode(binary(), atom()) :: binary()
  defp unencode(value, :binary), do: value
  defp unencode(value, :hex), do: decode_hex(value)

  @spec decode_hex(binary()) :: binary()
  defp decode_hex(binary) do
    Base.decode16!(binary, case: :lower)
  end
end
