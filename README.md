# ExRLP

[![CircleCI](https://circleci.com/gh/mana-ethereum/ex_rlp.svg?style=svg)](https://circleci.com/gh/mana-ethereum/ex_rlp)
[![Module Version](https://img.shields.io/hexpm/v/ex_rlp.svg)](https://hex.pm/packages/ex_rlp)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/ex_rlp/)
[![Total Download](https://img.shields.io/hexpm/dt/ex_rlp.svg)](https://hex.pm/packages/ex_rlp)
[![License](https://img.shields.io/hexpm/l/ex_rlp.svg)](https://github.com/mana-ethereum/ex_rlp/blob/master/LICENSE)
[![Last Updated](https://img.shields.io/github/last-commit/mana-ethereum/ex_rlp.svg)](https://github.com/mana-ethereum/ex_rlp/commits/master)

Elixir implementation of Ethereum's RLP (Recursive Length Prefix) encoding.

The encoding's specification can be found in [the yellow paper](http://yellowpaper.io/) or in the [ethereum wiki](https://github.com/ethereum/wiki/wiki/RLP).

## Installation

The easiest way to add ExRLP to your project is by [using Mix](http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html).

Add `:ex_rlp` as a dependency to your project's `mix.exs`:

```elixir
defp deps do
  [
    {:ex_rlp, "~> 0.6.0"}
  ]
end
```

And run:

```bash
$ mix deps.get
```

## Basic Usage

Use `ExRLP.encode/1` method to encode an item to RLP representation. An item can be non-negative integer, binary or list. List can contain integers, binaries or lists.

```elixir
iex> "dog" |> ExRLP.encode(encoding: :hex)
"83646f67"

iex> "dog" |> ExRLP.encode(encoding: :binary)
<<0x83, 0x64, 0x6f, 0x67>>

iex> 1000 |> ExRLP.encode(encoding: :hex)
"8203e8"

# Default encoding is binary
iex> 1000 |> ExRLP.encode
<<0x82, 0x03, 0xe8>>

iex> [ [ [], [] ], [] ] |> ExRLP.encode(encoding: :hex)
"c4c2c0c0c0"
```

Use `ExRLP.decode/1` method to decode a RLP encoded data. All items except lists are decoded as binaries so additional deserialization is needed if initially an item of another type was encoded.


```elixir
iex> "83646f67" |> ExRLP.decode(encoding: :hex)
"dog"

iex> "8203e8" |> ExRLP.decode(encoding: :hex) |> :binary.decode_unsigned
1000

iex> "c4c2c0c0c0" |> ExRLP.decode(encoding: :hex)
[[[], []], []]
```

More examples can be found in test files.

## Protocols

You can define protocols for encoding/decoding custom data types.

```elixir
defmodule ExRLP.LogEntry do
  defstruct address: nil, topics: [], data: nil

  @type t :: %__MODULE__{
          address: EVM.address(),
          topics: [integer()],
          data: binary()
        }

  @spec new(binary, [integer()], binary()) :: t()
  def new(address, topics, data) do
    %__MODULE__{
      address: address,
      topics: topics,
      data: data
    }
  end

  def to_list(log) do
    [log.address, log.topics, log.data]
  end
end

defimpl ExRLP.Encode, for: ExRLP.LogEntry do
  alias ExRLP.{Encode, LogEntry}

  @spec encode(LogEntry.t(), keyword()) :: binary()
  def encode(log, options \\ []) do
    log
    |> LogEntry.to_list()
    |> Encode.encode(options)
  end
end
```

## Contributing

1. [Fork it!](https://github.com/exthereum/ex_rlp/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Author

Ayrat Badykov (@ayrat555)

## Copyright and License

Copyright (c) 2017 Geoffrey Hayes, Ayrat Badykov, Mason Forest

ExRLP is released under the MIT License. See the [LICENSE.md](./LICENSE.md) file
for further details.
