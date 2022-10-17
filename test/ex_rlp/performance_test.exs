defmodule ExRLP.PerformanceTest do
  use ExUnit.Case

  @large_rlp (for _ <- 1..100_000 do
                [<<1>>, [<<1>>, <<2>>]]
              end)

  test "large rlp list" do
    start = time_start()

    assert @large_rlp
           |> ExRLP.encode()
           |> ExRLP.decode() == @large_rlp

    assert elapsed(start) < 20
  end

  defp time_start do
    Time.utc_now()
  end

  defp elapsed(start) do
    Time.diff(Time.utc_now(), start, :second)
  end
end
