defmodule ExRLP.Decode do
  @moduledoc false

  @spec decode(binary(), keyword()) :: ExRLP.t()
  def decode(item, options \\ []) when is_binary(item) do
    item
    |> unencode(Keyword.get(options, :encoding, :binary))
    |> decode_item
  end

  @spec unencode(binary() | String.t(), atom()) :: binary()
  defp unencode(value, :binary), do: value
  defp unencode(value, :hex), do: Base.decode16!(value, case: :lower)

  @spec decode_item(binary(), ExRLP.t()) :: ExRLP.t()
  defp decode_item(rlp_binary, result \\ nil)

  # When we don't have any RLP left, return the accumulator
  defp decode_item(<<>>, result), do: result

  # Decodes the head represents an item to be added directly
  # to the result.
  defp decode_item(<<(<<prefix>>), tail::binary>>, result) when prefix < 128 do
    new_result = add_new_item(result, <<prefix>>)

    decode_item(tail, new_result)
  end

  # Decodes medium length-binary?
  defp decode_item(<<(<<prefix>>), tail::binary>>, result) when prefix <= 183 do
    {new_item, new_tail} = decode_medium_binary(prefix, tail, 128)

    new_result = add_new_item(result, new_item)

    decode_item(new_tail, new_result)
  end

  # Decodes long length-binary?
  defp decode_item(<<(<<be_size_prefix>>), tail::binary>>, result) when be_size_prefix < 192 do
    {new_item, new_tail} = decode_long_binary(be_size_prefix, tail, 183)

    new_result = add_new_item(result, new_item)

    decode_item(new_tail, new_result)
  end

  # Decodes an empty list
  defp decode_item(<<(<<be_size_prefix>>), tail::binary>>, result)
       when be_size_prefix == 192 do
    new_result = add_new_item(result, [])

    decode_item(tail, new_result)
  end

  defp decode_item(<<(<<prefix>>), tail::binary>>, result) do
    {list_bin, new_tail} =
      if prefix <= 247 do
        decode_medium_binary(prefix, tail, 192)
      else
        decode_long_binary(prefix, tail, 247)
      end

    next_list =
      list_bin
      |> decode_item([])
      |> Enum.reverse()

    new_result = add_new_item(result, next_list)

    decode_item(new_tail, new_result)
  end

  def add_new_item(nil, new_item) do
    new_item
  end

  def add_new_item(result, new_item) do
    [new_item | result]
  end

  @spec decode_medium_binary(integer(), binary(), integer()) :: {binary(), binary()}
  defp decode_medium_binary(length_prefix, tail, prefix) do
    item_length = length_prefix - prefix
    <<item::binary-size(item_length), new_tail::binary()>> = tail

    {item, new_tail}
  end

  @spec decode_long_binary(integer(), binary(), integer()) :: {binary(), binary()}
  defp decode_long_binary(be_size_prefix, tail, prefix) do
    be_size = be_size_prefix - prefix
    <<be::binary-size(be_size), data::binary()>> = tail

    item_length = :binary.decode_unsigned(be)

    <<item::binary-size(item_length), new_tail::binary()>> = data

    {item, new_tail}
  end
end
