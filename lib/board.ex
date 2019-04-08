defmodule Board do
  def handle_board_update(result, board_data, player_symbol) do
    {status, position_to_update} = result

    case status do
      :ok -> {:ok, Map.replace!(board_data, position_to_update, player_symbol)}
      :error -> result
    end
  end

  def has_empty_spaces?(board) do
    board
    |> Map.values()
    |> Enum.any?(fn value -> value == " " end)
  end

  def is_a_empty_space(board_position, board) do
    Map.get(board, board_position) == " "
  end

  def convert_horizontal_to_row(board) do
    board
    |> Map.values()
    |> Enum.chunk_every(3)
  end

  def convert_vertical_to_row(board) do
    Enum.map(1..3, fn row_idx -> [board[row_idx], board[row_idx + 3], board[row_idx + 6]] end)
  end

  def convert_diagonal_to_row(board) do
    Enum.map([1, 3], fn row_idx ->
      cond do
        row_idx == 1 -> [board[row_idx], board[row_idx + 4], board[row_idx + 8]]
        row_idx == 3 -> [board[row_idx], board[row_idx + 2], board[row_idx + 4]]
      end
    end)
  end

  def generate_board_data(num_of_rows, num_of_columns) do
    1..(num_of_rows * num_of_columns)
    |> Enum.reduce(%{}, fn (num, acc) -> Map.put(acc, num, " ") end)
  end
end
