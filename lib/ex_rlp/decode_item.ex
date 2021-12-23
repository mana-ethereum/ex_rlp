defmodule ExRLP.DecodeItem do
  @moduledoc """
  Captures bins and decodes them.
  """

  @spec decode_item(binary()) :: ExRLP.t()
  def decode_item(rlp_binary), do: do_decode_item(rlp_binary, nil)
  ##
  ## HANDLING 0 - 127
  ##

  # decodes an item or a list of items from the given binary
  #
  # `payload` - binary containing the item(s) to decode
  # `list_result` - possibly a result of decoding a list payload:
  #   - if `nil`: we are not processing a list
  #   - if a list: we are processing a list, and we have this much currently
  @spec do_decode_item(payload :: binary(), list_result :: ExRLP.t()) :: ExRLP.t()
  defp do_decode_item(<<n, tail::binary>>, nil) when n < 128,
    do: do_decode_item(tail, <<n>>)

  defp do_decode_item(<<n, tail::binary>>, result) when n < 128,
    do: do_decode_item(tail, [<<n>> | result])

  ##
  ## FINISHED HANDLING 0 - 127
  ##

  ##
  ## HANDLING 128 - 183
  ##
  defp do_decode_item(<<129>>, _) do
    raise(ExRLP.DecodeError)
  end

  defp do_decode_item(<<129, bad::little-size(8), _tail::binary>>, _) when bad < 128 do
    raise(ExRLP.DecodeError)
  end

  defp do_decode_item(<<129, bad::little-size(8)>>, _) when bad < 128 do
    raise(ExRLP.DecodeError)
  end

  defp do_decode_item(<<n, tail::binary>>, nil) when n < 184 do
    do_decode_when_valid_length(n - 128, tail, nil)
  end

  defp do_decode_item(<<n, tail::binary>>, result) when n < 184 do
    do_decode_when_valid_length(n - 128, tail, result)
  end

  ##
  ## FINISHED HANDLING 128-183
  ##

  # decode_long_binary - CAN'T OPTIMISE FOR NOW
  defp do_decode_item(<<be_size_prefix, tail::binary>>, nil) when be_size_prefix < 192 do
    {new_item, new_tail} = decode_long_binary(be_size_prefix - 183, tail)

    do_decode_item(new_tail, new_item)
  end

  defp do_decode_item(<<be_size_prefix, tail::binary>>, result) when be_size_prefix < 192 do
    {new_item, new_tail} = decode_long_binary(be_size_prefix - 183, tail)

    do_decode_item(new_tail, [new_item | result])
  end

  ##
  ## HANDLING 192
  ##
  defp do_decode_item(<<192, tail::binary>>, nil) do
    do_decode_item(tail, [])
  end

  defp do_decode_item(<<192, tail::binary>>, result) do
    do_decode_item(tail, [[] | result])
  end

  ##
  ## FINISHED HANDLING 192
  ##

  ##
  ## HANDLING 193-247
  ##
  defp do_decode_item(<<n, tail::binary>>, nil) when n < 248 do
    size = n - 192

    if byte_size(tail) >= size do
      <<item::binary-size(size), new_tail::binary>> = tail
      new_item = Enum.reverse(do_decode_item(item, []))
      do_decode_item(new_tail, new_item)
    else
      raise(ExRLP.DecodeError)
    end
  end

  defp do_decode_item(<<n, tail::binary>>, result) when n < 248 do
    size = n - 192

    if byte_size(tail) >= size do
      <<item::binary-size(size), new_tail::binary>> = tail
      new_item = do_decode_item(item, [])
      do_decode_item(new_tail, [new_item | result])
    else
      raise(ExRLP.DecodeError)
    end
  end

  ##
  ## FINISHED HANDLING 193-247
  ##

  # decode_long_binary - CAN'T OPTIMISE FOR NOW
  defp do_decode_item(<<be_size_prefix, tail::binary>>, nil) when be_size_prefix > 247 do
    {list_binary, new_tail} = decode_long_binary(be_size_prefix - 247, tail)
    reversed_list = do_decode_item(list_binary, [])
    new_result = Enum.reverse(reversed_list)

    do_decode_item(new_tail, new_result)
  end

  defp do_decode_item(<<be_size_prefix, tail::binary>>, result) when be_size_prefix > 247 do
    {list_binary, new_tail} = decode_long_binary(be_size_prefix - 247, tail)
    list = do_decode_item(list_binary, [])

    do_decode_item(new_tail, [list | result])
  end

  defp do_decode_item(<<>>, result) when is_list(result) do
    Enum.reverse(result)
  end

  defp do_decode_item(<<>>, result), do: result

  defp do_decode_when_valid_length(size, tail, result) when byte_size(tail) >= size do
    <<item::binary-size(size), new_tail::binary>> = tail

    if result do
      do_decode_item(new_tail, [item | result])
    else
      do_decode_item(new_tail, item)
    end
  end

  defp do_decode_when_valid_length(_size, _tail, _result), do: raise(ExRLP.DecodeError)

  # decodes a long string or long list, based on the already decoded size of length provided (`be_size`)
  #
  # `be_size` - size of the length component in `tail`
  # `tail` - chunk of the binary containing the length and then the payload
  #
  # returns the resulting `item` and `new_tail` which is the remainder of the RLP structure to decode, if encoding OK
  @spec decode_long_binary(integer(), binary()) :: {binary(), binary()}

  # leading zeroes in length
  defp decode_long_binary(_, <<0, _::binary>>), do: raise(ExRLP.DecodeError)

  defp decode_long_binary(be_size, tail) do
    <<be::binary-size(be_size), data::binary>> = tail

    item_length = :binary.decode_unsigned(be)

    case {item_length, data} do
      # item length doesn't mandate long array / long list
      {bad_length, _} when bad_length < 55 -> raise(ExRLP.DecodeError)
      # all good
      {_, <<item::binary-size(item_length), new_tail::binary>>} -> {item, new_tail}
      # not enough of bytes in the payload
      {_, short_binary} when is_binary(short_binary) -> raise(ExRLP.DecodeError)
    end
  end
end
