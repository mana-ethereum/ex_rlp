defmodule ExRLP.Decode do
  @moduledoc false

  @spec decode(binary(), keyword()) :: ExRLP.t()
  def decode(item, options \\ []) when is_binary(item) do
    case item
         |> unencode(Keyword.get(options, :encoding, :binary))
         |> decode_item do
      [res] -> res
      [] -> nil
      els -> els
    end
  end

  @spec unencode(binary() | String.t(), atom()) :: binary()
  defp unencode(value, :binary), do: value
  defp unencode(value, :hex), do: Base.decode16!(value, case: :lower)

  @spec decode_item(binary(), ExRLP.t()) :: ExRLP.t()
  defp decode_item(rlp_binary, result \\ [])

  # When we don't have any RLP left, return the accumulator
  defp decode_item(<<>>, result) do
    Enum.reverse(result)
  end

  # Decodes the head represents an item to be added directly
  # to the result.
  defp decode_item(<<(<<prefix>>), tail::binary>>, result) when prefix < 128 do
    decode_item(tail, [<<prefix>> | result])
  end

  # Decodes medium length-binary?
  defp decode_item(<<(<<prefix>>), tail::binary>>, result) when prefix <= 183 do
    {new_item, new_tail} = decode_medium_binary(prefix, tail, 128)

    decode_item(new_tail, [new_item | result])
  end

  # Decodes long length-binary?
  defp decode_item(<<(<<be_size_prefix>>), tail::binary>>, result) when be_size_prefix < 192 do
    {new_item, new_tail} = decode_long_binary(be_size_prefix, tail, 183)

    decode_item(new_tail, [new_item | result])
  end

  # Decodes an empty list
  defp decode_item(<<(<<be_size_prefix>>), tail::binary>>, result)
       when be_size_prefix == 192 do
    decode_item(tail, [[] | result])
  end

  defp decode_item(<<(<<prefix>>), tail::binary>>, result) do
    {list_bin, new_tail} =
      if prefix <= 247 do
        decode_medium_binary(prefix, tail, 192)
      else
        decode_long_binary(prefix, tail, 247)
      end

    next_list = decode_item(list_bin, [])

    decode_item(new_tail, [next_list | result])
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
