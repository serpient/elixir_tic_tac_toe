defmodule ProcessInput do
  def transform_to_integer(string) do
    Integer.parse(string)
  end

  def handle_integer_conversion_result(string) when is_tuple(string) do
    string
    |> Tuple.to_list()
    |> Enum.fetch!(0)
  end

  def handle_integer_conversion_result(_string) do
    {:error, :invalid_input}
  end

  defp validate_input(result, board_state) when is_integer(result) do
    board = BoardState.board(board_state)
    max_spaces = BoardState.max_spaces(board_state)

    cond do
      Board.is_a_empty_space(result, board) == true -> {:ok, result}
      result > max_spaces || result < 1 -> {:error, :invalid_input_range}
      true -> {:error, :duplicate_input}
    end
  end

  defp validate_input(error, _board_state) do
    error
  end

  def handle_input(input, board_state) do
    input
    |> transform_to_integer
    |> handle_integer_conversion_result
    |> validate_input(board_state)
  end
end
