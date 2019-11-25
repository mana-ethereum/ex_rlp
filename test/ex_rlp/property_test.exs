defmodule ExRLP.PropTest do
  @moduledoc false

  use PropCheck
  use ExUnit.Case

  def safe_decode(binary) do
    try do
      ExRLP.decode(binary)
    rescue
      _ -> :decoder_crashed
    end
  end

  # Looks for cases where decoding is not one-to-one. Note: no claims about the encoder are checked here!
  # If we will find two distinct binaries that decode to the same elixir value, we've found our counterexample.
  # Lists and sorting are used as a performance optimization.
  # This allows us to do n^2 effective checks in search space while making just n runs of generator,
  # 2n runs of the decoder and n*log(n) value comparisons.
  property "decoding is one to one", [1000, :verbose, max_size: 100, constraint_tries: 100_000] do
    # This generator will generate random binaries until one will decode or constraint_tries.
    decodable_binary_generator =
      such_that(bin <- binary(), when: :decoder_crashed != safe_decode(bin))

    forall list_of_decodable_binaries <- list(decodable_binary_generator) do
      # Make sure there are no duplicates in encoded values.
      list_of_decodable_binaries = :lists.usort(list_of_decodable_binaries)
      decoded_items = for item <- list_of_decodable_binaries, do: ExRLP.decode(item)
      # Assert that list of decoded structures contain no duplicates.
      :lists.sort(decoded_items) == :lists.usort(decoded_items)
    end
  end

  property "for any string encoding is one to one", [1000, :verbose, max_size: 100] do
    forall l <- binary() do
      encoded = ExRLP.encode(l)
      decoded = ExRLP.decode(encoded)
      l == decoded
    end
  end

  # This test searches in at most 3 layers of nesting for lists because of lack of
  # support for recursive types in propcheck.
  # For details see: https://github.com/alfert/propcheck/issues/5 and related issues / PRs.
  property "for lists encoding is one to one", [1000, :verbose, max_size: 100] do
    forall l <-
             union([
               list(binary()),
               binary(),
               union([list(binary()), binary(), union([list(binary()), binary()])])
             ]) do
      encoded = ExRLP.encode(l)
      decoded = ExRLP.decode(encoded)
      l == decoded
    end
  end
end
