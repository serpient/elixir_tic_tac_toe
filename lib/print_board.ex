defmodule PrintBoard do
  def get_cell_part(cell_level, at_end_of_cell_line?, value) do
    line = %{
      "top" => String.pad_trailing("#{value}", 5),
      "middle" => "  #{value}  ",
      "bottom" => "_____",
      "bottom_of_last_row" => "     "
    }

    cond do
      at_end_of_cell_line? == false -> line[cell_level] <> "|"
      true -> line[cell_level]
    end
  end

  def list_of_a_single_cells_parts(
    column_idx,
    num_of_columns,
    num_of_rows,
    row_idx,
    board_data
  ) do
  curr_column_number = row_idx * num_of_columns + column_idx
  at_end_of_cell? = column_idx == num_of_columns
  bottom = if num_of_rows - 1 == row_idx, do: "bottom_of_last_row", else: "bottom"

  [
    get_cell_part("top", at_end_of_cell?, curr_column_number),
    get_cell_part("middle", at_end_of_cell?, board_data[curr_column_number]),
    get_cell_part(bottom, at_end_of_cell?, nil)
  ]
end

  def compile_row_of_cells(num_of_columns, num_of_rows, row_idx, board_data) do
    1..num_of_columns
    |> Enum.map(fn column_idx -> list_of_a_single_cells_parts(column_idx, num_of_columns, num_of_rows, row_idx, board_data) end)
    |> Enum.zip()
    |> Enum.map_join(fn value ->
      Tuple.append(value, "\n") |> Tuple.to_list()
    end)
  end

  def generate_board_for_print(board_spec) do
    %Board{board_data: board_data, num_of_columns: num_of_columns, num_of_rows: num_of_rows} = board_spec

    0..(num_of_rows - 1)
    |> Enum.map(fn row_idx -> compile_row_of_cells(num_of_columns, num_of_rows, row_idx, board_data) end)
    |> List.insert_at(0, "\n")
    |> List.insert_at(-1, "\n\n\n")
    |> Enum.join
  end
end
