defmodule Board do
  defstruct num_of_rows: 3, num_of_columns: 3, board_data: %{
    1 => " ",
    2 => " ",
    3 => " ",
    4 => " ",
    5 => " ",
    6 => " ",
    7 => " ",
    8 => " ",
    9 => " "
  }, max_spaces: 9
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

  def convert_horizontal_to_row(board_spec) do
    board = board_spec.board_data

    board
    |> Map.values()
    |> Enum.chunk_every(board_spec.num_of_columns)
  end

  def convert_vertical_to_row(board_spec) do
    board = board_spec.board_data
    Enum.map(1..3, fn row_idx -> [board[row_idx], board[row_idx + 3], board[row_idx + 6]] end)
  end

  def convert_diagonal_to_row(board_spec) do
    board = board_spec.board_data
    Enum.map([1, 3], fn row_idx ->
      cond do
        row_idx == 1 -> [board[row_idx], board[row_idx + 4], board[row_idx + 8]]
        row_idx == 3 -> [board[row_idx], board[row_idx + 2], board[row_idx + 4]]
      end
    end)
  end

  def generate_board_data(num_of_rows \\ 3, num_of_columns \\ 3) do
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
      at_end_of_cell_line? == false -> line[cell_level] <> "|"
      true -> line[cell_level]
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
        get_cell_part("middle", at_end_of_cell?,  board_data[curr_column_number]),
        get_cell_part(bottom, at_end_of_cell?, nil)
      ]
    end)
    |> Enum.zip()
    |> Enum.map_join(fn value ->
      Tuple.append(value, "\n") |> Tuple.to_list
    end)
  end

  def generate_board_for_print(board_spec) do
    new_line = "\n"
    margin_bottom = "\n\n\n"
    %Board{board_data: board_data, num_of_columns: num_of_columns, num_of_rows: num_of_rows} = board_spec

    string_board =
      0..(num_of_rows - 1)
      |> Enum.reduce(new_line, fn row_idx, acc ->
        acc <> compile_row_of_cells(num_of_columns, num_of_rows, row_idx, board_data)
      end)

    string_board <> margin_bottom
  end

  def update_board_spec(new_board_data, new_num_of_rows, new_num_of_columns) do
    existing_board = %Board{}
    %Board{
      existing_board
      | board_data: new_board_data,
        num_of_rows: new_num_of_rows,
        num_of_columns: new_num_of_columns,
        max_spaces: new_num_of_rows * new_num_of_columns
    }
  end
end
