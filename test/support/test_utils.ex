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

  def normalize_data("0x" <> number) do
    Base.decode16!(number, case: :lower)
  end

  def normalize_data(data) when is_list(data) do
    Enum.map(data, &normalize_data/1)
  end

  def normalize_data(input), do: input

  def normalize_decoded_data(input, output, acc \\ [])

  def normalize_decoded_data(input, output, _) when is_number(output) do
    :binary.decode_unsigned(input)
  end

  def normalize_decoded_data("0x" <> input, _output, _) do
    Base.decode16!(input, case: :lower)
  end

  def normalize_decoded_data([], [], acc), do: Enum.reverse(acc)

  def normalize_decoded_data([in_head | in_tail], [out_head | out_tail], acc) do
    normalized_item = normalize_decoded_data(in_head, out_head)

    normalize_decoded_data(in_tail, out_tail, [normalized_item | acc])
  end

  def normalize_decoded_data(input, _output, _acc), do: input

  # this is a taylored version to decode from the invalidRLPTest.json cases
  def normalize_invalid_case_data("0x" <> encoded), do: Base.decode16!(encoded, case: :mixed)

  def normalize_invalid_case_data(encoded) when is_binary(encoded),
    do: Base.decode16!(encoded, case: :mixed)
end
