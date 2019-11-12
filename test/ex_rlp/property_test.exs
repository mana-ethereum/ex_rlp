defmodule ExRLP.PropTest do
  @moduledoc false

  use PropCheck
  use ExUnit.Case

  def safe_decode(t) do
    try do
      ExRLP.decode(t)
    rescue
      _ -> false
    end
  end

  property "decoding is one to one", [1000, :verbose, max_size: 100, constraint_tries: 100_000] do
    gen = such_that(bin <- binary(), when: false != safe_decode(bin))

    forall l <- list(gen) do
      mapsto = for item <- :lists.usort(l), do: ExRLP.decode(item)
      :lists.sort(mapsto) == :lists.usort(mapsto)
    end
  end

  property "for any string encoding is one to one", [1000, :verbose, max_size: 100] do
    forall l <- binary() do
      encoded = ExRLP.encode(l)
      decoded = ExRLP.decode(encoded)
      l == decoded
    end
  end

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
