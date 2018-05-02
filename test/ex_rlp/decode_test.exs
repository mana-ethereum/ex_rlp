defmodule ExRLP.DecodeTest do
  use ExUnit.Case
  alias ExRLP.Decode
  import ExRLP.TestUtils

  describe "decode/2" do
    test "correctly decodes objects" do
      test_file_name = "rlptest.json"

      test_file_name
      |> read_json_file
      |> Enum.each(fn {test_name, %{"in" => expected_result, "out" => input}} ->
        expected_result = expected_result |> normalize_data

        result =
          input
          |> Decode.decode(encoding: :hex)
          |> normalize_decoded_data(expected_result)

        assert result == expected_result,
               "Test for #{test_name} failed, expected #{result} to equal to #{expected_result}"
      end)
    end
  end
end
