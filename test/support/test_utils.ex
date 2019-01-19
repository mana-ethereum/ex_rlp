defmodule ExRLP.TestUtils do
  @moduledoc false
  @tests_directory "test/support/ethereum_common_tests/RLPTests/"

  def read_json_file(file_name) do
    {:ok, body} = File.read(@tests_directory <> file_name)

    Poison.decode!(body)
  end

  def normalize_data("#" <> number) do
    {num, ""} = Integer.parse(number)

    num
  end

  def normalize_data(input), do: input

  def normalize_decoded_data(input, output, acc \\ [])

  def normalize_decoded_data(input, output, _) when is_number(output) do
    input |> :binary.decode_unsigned()
  end

  def normalize_decoded_data([], [], acc), do: acc

  def normalize_decoded_data([in_head | in_tail], [out_head | out_tail], acc) do
    normalized_item = normalize_decoded_data(in_head, out_head)

    normalize_decoded_data(in_tail, out_tail, acc ++ [normalized_item])
  end

  def normalize_decoded_data(input, _output, _acc), do: input
end
