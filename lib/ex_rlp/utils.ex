defmodule ExRLP.Utils do
  @moduledoc false

  @spec maybe_encode_hex(binary(), atom()) :: binary()
  def maybe_encode_hex(value, :hex), do: encode_hex(value)
  def maybe_encode_hex(value, _encoding), do: value

  @spec encode_hex(binary()) :: binary()
  def encode_hex(binary) do
    Base.encode16(binary, case: :lower)
  end

  @spec big_endian_size(binary(), boolean()) :: bitstring()
  def big_endian_size(binary, trim_trailing_zeroes \\ false)

  def big_endian_size(binary, false) do
    binary
    |> byte_size
    |> :binary.encode_unsigned()
  end

  def big_endian_size(binary, true) do
    binary
    |> :binary.decode_unsigned(:little)
    |> :binary.encode_unsigned(:big)
    |> byte_size
    |> :binary.encode_unsigned()
  end
end
