defmodule ProcessInput do
  def transform_to_integer(string) do
    parse_result = Integer.parse(string)
    case parse_result do
      :error -> {:error, :invalid_input}
      _ -> {integer, _remainder} = parse_result; integer
    end
  end

  defp validate_input(result, board_state) when is_integer(result) do
    board = BoardState.board(board_state)
    max_spaces = BoardState.max_spaces(board_state)

    cond do
      Board.is_position_empty?(result, board) == true -> {:ok, result}
      result > max_spaces || result < 1 -> {:error, :invalid_input_range}
      true -> {:error, :duplicate_input}
    end
  end

  defp validate_input(error, _board_state) do
    error
  end

  def validate_board_size_input(result) do
    case result do
      3 -> {:ok, result}
      4 -> {:ok, result}
      _ -> {:error, :invalid_board_size_input}
    end
  end

  def validate_opponent_type_input(result) do
    case result do
      "C" -> {:ok, :ai}
      "L" -> {:ok, :opponent}
      _ -> {:error, :invalid_opponent_type_input}
    end
  end

  def handle_input(input, board_state) do
    input
    |> transform_to_integer
    |> validate_input(board_state)
  end

  def handle_board_size_input(input) do
    input
    |> transform_to_integer()
    |> validate_board_size_input()
  end

  def handle_opponent_type_input(input) do
    input
    |> to_string()
    |> String.trim()
    |> validate_opponent_type_input()
  end
end
