defmodule ExRLP.DecodeError do
  @moduledoc """
  Raised if an invalid RLP encoding is detected, as in
  [https://github.com/ethereum/wiki/wiki/rlp](https://github.com/ethereum/wiki/wiki/rlp).
  """
  defexception message: "invalid rlp encoding"
end
