defmodule PrintableBoard do
  def generate_board_for_print(state) do
    board_size = BoardState.size(state)
    board = BoardState.get_string_values(state)

    0..(board_size - 1)
    |> Enum.map(fn row_idx ->
      at_bottom_of_last_row? = board_size - 1 == row_idx

      create_row_of_cells(board_size, row_idx, at_bottom_of_last_row?, board)
      |> zip_cell_parts_into_list()
    end)
    |> add_top_and_bottom_padding()
    |> Enum.join()
  end

  defp create_row_of_cells(board_size, row_idx, at_bottom_of_last_row?, board_data) do
    1..board_size
    |> Enum.map(fn column_idx ->
      current_cell_display_number = row_idx * board_size + column_idx
      at_end_of_cell? = column_idx == board_size

      create_parts_for_a_single_cell(
        current_cell_display_number,
        at_end_of_cell?,
        at_bottom_of_last_row?,
        board_data
      )
    end)
  end

  defp create_parts_for_a_single_cell(
        current_cell_display_number,
        at_end_of_cell?,
        at_bottom_of_last_row?,
        board_data
      ) do
    bottom = if at_bottom_of_last_row?, do: "empty_space", else: "bottom_border"

    [
      get_cell_part("label", at_end_of_cell?, current_cell_display_number),
      get_cell_part("symbol", at_end_of_cell?, Enum.at(board_data, current_cell_display_number - 1)),
      get_cell_part(bottom, at_end_of_cell?, nil)
    ]
  end

  defp get_cell_part(cell_part, at_end_of_cell?, value) do
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

  defp zip_cell_parts_into_list(list_of_parts) do
    list_of_parts
    |> Enum.zip()
    |> Enum.map_join(fn value ->
      value
      |> Tuple.append("\n")
      |> Tuple.to_list()
    end)
  end

  defp add_top_and_bottom_padding(list) do
    list
    |> List.insert_at(0, "\n")
    |> List.insert_at(-1, "\n\n\n")
  end
end
