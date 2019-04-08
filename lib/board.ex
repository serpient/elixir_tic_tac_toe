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

  def generate_board_for_print(num_of_rows, num_of_columns, board_data) do
    new_line = "\n"
    margin_bottom = "\n\n\n"

    Enum.reduce(0..num_of_rows - 1, new_line, fn (row_idx, acc) ->
      acc <> Enum.reduce(1..num_of_columns, "", fn (column_idx, acc) ->
        curr_column_number = row_idx * num_of_columns + (column_idx)
        print = cond do
          (column_idx == num_of_columns) == false -> "#{curr_column_number}    |"
          (column_idx == num_of_columns) == true -> "#{curr_column_number}    "
        end
        acc <> print
      end )
      <> new_line
      <> Enum.reduce(1..num_of_columns, "", fn (column_idx, acc) ->
        curr_column_number = row_idx * num_of_columns + (column_idx)
        curr_column_value = Map.get(board_data, curr_column_number)
        print = cond do
          (column_idx == num_of_columns) == false -> "  #{curr_column_value}  |"
          (column_idx == num_of_columns) == true -> "  #{curr_column_value}  "
        end
        acc <> print
      end )
      <> new_line
      <> Enum.reduce(1..num_of_columns, "", fn (column_idx, acc) ->
        print = if (num_of_rows - 1 == row_idx) do
          cond do
            (column_idx == num_of_columns) == false -> "     |"
            (column_idx == num_of_columns) == true -> "     "
          end
        else
          cond do
            (column_idx == num_of_columns) == false -> "_____|"
            (column_idx == num_of_columns) == true -> "_____"
          end
        end
        acc <> print
      end ) <> new_line
    end
    ) <> margin_bottom
  end
end
