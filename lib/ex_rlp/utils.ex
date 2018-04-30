defmodule ExRLP.Utils do
  @moduledoc false

  @spec maybe_encode_hex(binary(), atom()) :: binary()
  def maybe_encode_hex(value, :hex), do: encode_hex(value)
  def maybe_encode_hex(value, _encoding), do: value

  @spec encode_hex(binary()) :: binary()
  def encode_hex(binary) do
    binary |> Base.encode16(case: :lower)
  end

  @spec big_endian_size(binary()) :: bitstring()
  def big_endian_size(binary) do
    binary
    |> byte_size
    |> :binary.encode_unsigned()
  end
end
