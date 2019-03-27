defmodule ProcessInput do
  def transform_to_integer(string) do
    Integer.parse(string)
  end

  def process_input(string, _board, _current_player) when is_tuple(string) do
    string
    |> Tuple.to_list()
    |> Enum.fetch!(0)
  end

  def process_input(_string, _board, _current_player) do
    {:error, :invalid_input}
  end

  def is_empty(board_position, board) do
    Map.get(board, board_position) == " "
  end

  def validate_input(result, board, _current_player) when is_integer(result) do
    cond do
      is_empty(result, board) == true -> {:ok, result}
      result > 9 || result < 1 -> {:error, :invalid_input_range}
      true -> {:error, :duplicate_input}
    end
  end

  def validate_input(error, _board, _current_player) do
    error
  end

  def handle_input(input, board, current_player) do
    input
    |> transform_to_integer
    |> process_input(board, current_player)
    |> validate_input(board, current_player)
  end
end
