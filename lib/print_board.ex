defmodule PrintBoard do
  def get_cell_part(cell_part, at_end_of_cell?, value) do
    draw = %{
      "label" => String.pad_trailing("#{value}", 5),
      "symbol" => "  #{value}  ",
      "bottom_border" => "_____",
      "empty_space" => "     "
    }

    cond do
      at_end_of_cell? -> draw[cell_part]
      true -> draw[cell_part] <> "|"
    end
  end

  def create_parts_for_a_single_cell(
        curr_column_number,
        at_end_of_cell?,
        at_bottom_of_last_row?,
        board_data
      ) do
    bottom = if at_bottom_of_last_row?, do: "empty_space", else: "bottom_border"

    [
      get_cell_part("label", at_end_of_cell?, curr_column_number),
      get_cell_part("symbol", at_end_of_cell?, board_data[curr_column_number]),
      get_cell_part(bottom, at_end_of_cell?, nil)
    ]
  end

  def create_row_of_cells(num_of_columns, row_idx, at_bottom_of_last_row?, board_data) do
    1..num_of_columns
    |> Enum.map(fn column_idx ->
      curr_column_number = row_idx * num_of_columns + column_idx
      at_end_of_cell? = column_idx == num_of_columns

      create_parts_for_a_single_cell(
        curr_column_number,
        at_end_of_cell?,
        at_bottom_of_last_row?,
        board_data
      )
    end)
  end

  def zip_cell_parts_into_list(list_of_parts) do
    list_of_parts
    |> Enum.zip()
    |> Enum.map_join(fn value ->
      value
      |> Tuple.append("\n")
      |> Tuple.to_list()
    end)
  end

  def add_top_and_bottom_padding(list) do
    list
    |> List.insert_at(0, "\n")
    |> List.insert_at(-1, "\n\n\n")
  end

  def generate_board_for_print(board_spec) do
    %Board{board_data: board_data, num_of_columns: num_of_columns, num_of_rows: num_of_rows} =
      board_spec

    0..(num_of_rows - 1)
    |> Enum.map(fn row_idx ->
      at_bottom_of_last_row? = num_of_rows - 1 == row_idx

      create_row_of_cells(num_of_columns, row_idx, at_bottom_of_last_row?, board_data)
      |> zip_cell_parts_into_list
    end)
    |> add_top_and_bottom_padding
    |> Enum.join()
  end
end
