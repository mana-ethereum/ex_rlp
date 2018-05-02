defmodule ExRLP.EncodeTest do
  use ExUnit.Case
  alias ExRLP.Encode
  import ExRLP.TestUtils

  describe "encode/2" do
    test "correctly encodes objects" do
      test_file_name = "rlptest.json"

      test_file_name
      |> read_json_file
      |> Enum.each(fn {test_name, %{"in" => input, "out" => expected_result}} ->
        result =
          input
          |> normalize_data()
          |> Encode.encode(encoding: :hex)

        assert result == expected_result,
               "Test for #{test_name} failed, expected #{result} to equal to #{expected_result}"
      end)
    end
  end
end
