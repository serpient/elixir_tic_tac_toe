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
    |> Enum.reduce(%{}, fn num, acc -> Map.put(acc, num, " ") end)
  end

  def get_cell_line_to_print(cell_level, at_end_of_cell_line?, value) do
    line_to_print =
      case cell_level do
        "top" -> String.pad_trailing("#{value}", 5)
        "middle" -> "  #{value}  "
        "bottom" -> "_____"
        "bottom_of_last_row" -> "     "
      end

    if at_end_of_cell_line?, do: line_to_print, else: line_to_print <> "|"
  end

  def print_cell_line(cell_level, num_of_columns, row_idx, board_data) do
    Enum.reduce(1..num_of_columns, "", fn column_idx, acc ->
      curr_column_number = row_idx * num_of_columns + column_idx

      cell_value =
        cond do
          cell_level == "middle" -> Map.get(board_data, curr_column_number)
          true -> curr_column_number
        end

      acc <> get_cell_line_to_print(cell_level, column_idx == num_of_columns, cell_value)
    end) <>
      "\n"
  end

  def print_cell_row(num_of_columns, num_of_rows, row_idx, board_data) do
    top_line = print_cell_line("top", num_of_columns, row_idx, board_data)
    middle_line = print_cell_line("middle", num_of_columns, row_idx, board_data)

    last_line =
      case num_of_rows - 1 == row_idx do
        true -> print_cell_line("bottom_of_last_row", num_of_columns, row_idx, board_data)
        false -> print_cell_line("bottom", num_of_columns, row_idx, board_data)
      end

    top_line <> middle_line <> last_line
  end

  def generate_board_for_print(num_of_rows, num_of_columns, board_data) do
    new_line = "\n"
    margin_bottom = "\n\n\n"

    Enum.reduce(0..(num_of_rows - 1), new_line, fn row_idx, acc ->
      acc <> print_cell_row(num_of_columns, num_of_rows, row_idx, board_data)
    end) <> margin_bottom


  end
end
