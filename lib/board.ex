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

  def get_cell_part(cell_level, at_end_of_cell_line?, value) do
    line = %{
      "top" => String.pad_trailing("#{value}", 5),
      "middle" => "  #{value}  ",
      "bottom" => "_____",
      "bottom_of_last_row" => "     "
    }

    cond do
      at_end_of_cell_line? -> line[cell_level]
      true -> line[cell_level] <> "|"
    end
  end

  def compile_row_of_cells(num_of_columns, num_of_rows, row_idx, board_data) do
    1..num_of_columns
    |> Enum.map(fn column_idx ->
      curr_column_number = row_idx * num_of_columns + column_idx
      at_end_of_cell? = column_idx == num_of_columns
      bottom = if num_of_rows - 1 == row_idx, do: "bottom_of_last_row", else: "bottom"
      [
        get_cell_part("top", at_end_of_cell?, curr_column_number),
        get_cell_part("middle", at_end_of_cell?, Map.get(board_data, curr_column_number)),
        get_cell_part(bottom, at_end_of_cell?, nil)
      ]
    end)
    |> Enum.zip()
    |> Enum.map_join(fn value ->
      Tuple.append(value, "\n") |> Tuple.to_list
    end)
  end

  def generate_board_for_print(num_of_rows, num_of_columns, board_data) do
    new_line = "\n"
    margin_bottom = "\n\n\n"

    0..(num_of_rows - 1)
    |> Enum.reduce(new_line, fn row_idx, acc ->
      acc <> compile_row_of_cells(num_of_columns, num_of_rows, row_idx, board_data)
    end)
    |> (fn (value) -> value <> margin_bottom end).()
  end
end
