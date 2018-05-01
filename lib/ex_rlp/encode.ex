defprotocol ExRLP.Encode do
  def encode(value, options \\ [])
end

defimpl ExRLP.Encode, for: BitString do
  alias ExRLP.Utils

  @spec encode(ExRLP.t(), keyword()) :: binary()
  def encode(value, options \\ []) do
    value
    |> encode_item
    |> Utils.maybe_encode_hex(Keyword.get(options, :encoding, :binary))
  end

  @spec encode_item(binary()) :: binary()
  defp encode_item(<<byte>> = item) when byte_size(item) == 1 and byte < 128 do
    item
  end

  defp encode_item(item) when is_binary(item) and byte_size(item) < 56 do
    prefix = 128 + byte_size(item)

    <<prefix>> <> item
  end

  defp encode_item(item) when is_binary(item) do
    be_size = item |> Utils.big_endian_size()
    byte_size = be_size |> byte_size

    <<183 + byte_size>> <> be_size <> item
  end
end

defimpl ExRLP.Encode, for: Integer do
  alias ExRLP.{Utils, Encode}

  @spec encode(ExRLP.t(), keyword()) :: binary()
  def encode(value, options \\ []) when value >= 0 do
    value
    |> to_binary()
    |> Encode.encode()
    |> Utils.maybe_encode_hex(Keyword.get(options, :encoding, :binary))
  end

  @spec to_binary(integer()) :: binary()
  defp to_binary(object) when is_integer(object) and object == 0 do
    ""
  end

  defp to_binary(object) when is_integer(object) and object > 0 do
    object |> :binary.encode_unsigned()
  end
end

defimpl ExRLP.Encode, for: List do
  alias ExRLP.{Utils, Encode}

  @spec encode([ExRLP.t()], keyword()) :: binary()
  def encode(values, options \\ []) do
    values
    |> encode_items("")
    |> Utils.maybe_encode_hex(Keyword.get(options, :encoding, :binary))
  end

  @spec encode_items([ExRLP.t()], binary()) :: binary()
  defp encode_items([], acc) do
    acc |> prefix_list
  end

  defp encode_items([item | tail], acc) do
    encoded_item = item |> Encode.encode()

    tail |> encode_items(acc <> encoded_item)
  end

  @spec prefix_list(binary()) :: binary()
  defp prefix_list(encoded_concat) when byte_size(encoded_concat) < 56 do
    size = encoded_concat |> byte_size

    <<192 + size>> <> encoded_concat
  end

  defp prefix_list(encoded_concat) do
    be_size = encoded_concat |> Utils.big_endian_size()
    byte_size = be_size |> byte_size

    <<247 + byte_size>> <> be_size <> encoded_concat
  end
end
