defmodule ProcessInput do
  def transform_to_integer(string) do
    Integer.parse(string)
  end

  def process_input(string) when is_tuple(string) do
    string
    |> Tuple.to_list()
    |> Enum.fetch!(0)
  end

  def process_input(_string) do
    {:error, :invalid_input}
  end

  defp validate_input(result, board) when is_integer(result) do
    cond do
      Board.is_a_empty_space(result, board) == true -> {:ok, result}
      result > 9 || result < 1 -> {:error, :invalid_input_range}
      true -> {:error, :duplicate_input}
    end
  end

  defp validate_input(error, _board) do
    error
  end

  def handle_input(input, board) do
    input
    |> transform_to_integer
    |> process_input
    |> validate_input(board)
  end
end
