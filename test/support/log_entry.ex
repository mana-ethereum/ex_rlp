defmodule ExRLP.LogEntry do
  @moduledoc false

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
