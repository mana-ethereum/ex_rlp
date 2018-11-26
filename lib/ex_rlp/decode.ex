defmodule ExRLP.Decode do
  @moduledoc false

  @spec decode(binary(), keyword()) :: ExRLP.t()
  def decode(item, options \\ []) when is_binary(item) do
    item
    |> maybe_decode_hex(Keyword.get(options, :encoding, :binary))
    |> decode_item
  end

  @spec maybe_decode_hex(binary(), atom()) :: binary()
  defp maybe_decode_hex(value, :binary), do: value
  defp maybe_decode_hex(value, :hex), do: decode_hex(value)

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
    {new_item, new_tail} = decode_medium_binary(prefix, tail, 128)

    new_result = add_new_item(result, new_item)

    decode_item(new_tail, new_result)
  end

  defp decode_item(<<(<<be_size_prefix>>), tail::binary>>, result) when be_size_prefix < 192 do
    {new_item, new_tail} = decode_long_binary(be_size_prefix, tail, 183)

    new_result = add_new_item(result, new_item)

    decode_item(new_tail, new_result)
  end

  defp decode_item(<<(<<be_size_prefix>>), tail::binary>>, result) when be_size_prefix == 192 do
    new_item = []

    new_result = add_new_item(result, new_item)

    decode_item(tail, new_result)
  end

  defp decode_item(<<(<<prefix>>), tail::binary>>, result) when prefix <= 247 do
    {list, new_tail} = decode_medium_binary(prefix, tail, 192)

    new_result = add_decoded_list(result, list)

    decode_item(new_tail, new_result)
  end

  defp decode_item(<<(<<be_size_prefix>>), tail::binary>>, result) do
    {list, new_tail} = decode_long_binary(be_size_prefix, tail, 247)

    new_result = result |> add_decoded_list(list)

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

  @spec decode_medium_binary(integer(), binary(), integer()) :: {binary(), binary()}
  defp decode_medium_binary(length_prefix, tail, prefix) do
    item_length = length_prefix - prefix
    <<item::binary-size(item_length), new_tail::binary>> = tail

    {item, new_tail}
  end

  @spec decode_long_binary(integer(), binary(), integer()) :: {binary(), binary()}
  defp decode_long_binary(be_size_prefix, tail, prefix) do
    be_size = be_size_prefix - prefix
    <<be::binary-size(be_size), data::binary>> = tail

    item_length = :binary.decode_unsigned(be)
    <<item::binary-size(item_length), new_tail::binary>> = data

    {item, new_tail}
  end

  @spec decode_hex(binary()) :: binary()
  defp decode_hex(binary) do
    {:ok, decoded_binary} = Base.decode16(binary, case: :lower)

    decoded_binary
  end
end
