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
        expected_result = normalize_data(expected_result)

        result =
          input
          |> normalize_data()
          |> Decode.decode()
          |> normalize_decoded_data(expected_result)

        assert result == expected_result, "#{test_name} failed"
      end)
    end

    test "decodes nested lists" do
      expected_result =
        [["key1", "val1"], ["key2", "val2"], ["key3", "val3"], ["key4", "val4"]]
        |> normalize_data

      input =
        "ecca846b6579318476616c31ca846b6579328476616c32ca846b6579338476616c33ca846b6579348476616c34"

      result =
        input
        |> Decode.decode(encoding: :hex)
        |> normalize_decoded_data(expected_result)

      assert result == expected_result
    end
  end
end
