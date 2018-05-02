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
end
