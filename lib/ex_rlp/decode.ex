defmodule ExRLP.Decode do
  @moduledoc false

  @spec decode(binary(), keyword()) :: ExRLP.t()
  def decode(item, options \\ []) when is_binary(item) do
    item
    |> unencode(Keyword.get(options, :encoding, :binary))
    |> decode_item
  end

  @spec unencode(binary(), atom()) :: binary()
  defp unencode(value, :binary), do: value
  defp unencode(value, :hex), do: decode_hex(value)

  @spec decode_item(binary(), ExRLP.t()) :: ExRLP.t()
  defp decode_item(rlp_binary, result \\ nil)

  defp decode_item("", result) when is_list(result) do
    Enum.reverse(result)
  end

  defp decode_item("", result) do
    result
  end

  defp decode_item(<<(<<prefix>>), tail::binary>>, result) when prefix < 128 do
    new_item = <<prefix>>

    new_result = add_new_item(result, new_item)

    decode_item(tail, new_result)
  end

  defp decode_item(<<(<<prefix>>), tail::binary>>, result) when prefix <= 183 do
    {new_item, new_tail} = decode_medium_binary(tail, prefix, 128)

    new_result = add_new_item(result, new_item)

    decode_item(new_tail, new_result)
  end

  defp decode_item(<<(<<be_size_prefix>>), tail::binary>>, result) when be_size_prefix < 192 do
    {new_item, new_tail} = decode_long_binary(tail, be_size_prefix, 183)

    new_result = add_new_item(result, new_item)

    decode_item(new_tail, new_result)
  end

  defp decode_item(<<(<<be_size_prefix>>), tail::binary>>, result) when be_size_prefix == 192 do
    new_item = []

    new_result = add_new_item(result, new_item)

    decode_item(tail, new_result)
  end

  defp decode_item(<<(<<prefix>>), tail::binary>>, result) when prefix <= 247 do
    {list, new_tail} = decode_medium_binary(tail, prefix, 192)

    new_result = add_decoded_list(result, list)

    decode_item(new_tail, new_result)
  end

  defp decode_item(<<(<<be_size_prefix>>), tail::binary>>, result) do
    {list, new_tail} = decode_long_binary(tail, be_size_prefix, 247)

    new_result = add_decoded_list(result, list)

    decode_item(new_tail, new_result)
  end

  @spec add_new_item(ExRLP.t(), ExRLP.t()) :: ExRLP.t()
  def add_new_item(nil, new_item) do
    new_item
  end

  def add_new_item(result, new_item) do
    [new_item | result]
  end

  @spec add_decoded_list(ExRLP.t(), binary()) :: ExRLP.t()
  defp add_decoded_list(nil, rlp_list_binary) do
    rlp_list_binary
    |> decode_item([])
    |> Enum.reverse()
  end

  defp add_decoded_list(result, rlp_list_binary) do
    list_items = decode_item(rlp_list_binary, [])

    [list_items | result]
  end

  @spec decode_medium_binary(binary(), integer(), integer()) :: {binary(), binary()}
  defp decode_medium_binary(tail, length_prefix, prefix) do
    item_length = length_prefix - prefix

    fetch_head_and_tail(tail, item_length)
  end

  @spec decode_long_binary(binary(), integer(), integer()) :: {binary(), binary()}
  defp decode_long_binary(tail, be_size_prefix, prefix) do
    be_size = be_size_prefix - prefix

    {data, item_length} = fetch_length_and_tail(tail, be_size)

    fetch_head_and_tail(data, item_length)
  end

  @spec fetch_length_and_tail(binary(), integer()) :: {binary(), integer()}
  defp fetch_length_and_tail(data, length_size) do
    <<be::binary-size(length_size), data::binary>> = data

    item_length = :binary.decode_unsigned(be)

    {data, item_length}
  end

  @spec fetch_head_and_tail(binary(), integer()) :: {binary(), binary()}
  defp fetch_head_and_tail(data, head_length) do
    <<head::binary-size(head_length), tail::binary>> = data

    {head, tail}
  end

  @spec decode_hex(binary()) :: binary()
  defp decode_hex(binary) do
    Base.decode16!(binary, case: :lower)
  end
end
