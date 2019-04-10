defmodule Board do
  defstruct board_size: 3,
            board_data: %{
              1 => " ",
              2 => " ",
              3 => " ",
              4 => " ",
              5 => " ",
              6 => " ",
              7 => " ",
              8 => " ",
              9 => " "
            }

  def max_spaces(board_size) do
    board_size * board_size
  end

  def handle_board_update(result, board_spec, player_symbol) do
    {status, position_to_update} = result

    case status do
      :ok -> {:ok, update_data(position_to_update, board_spec, player_symbol)}
      :error -> result
    end
  end

  def update_data(position_to_update, board_spec, player_symbol) do
    %Board{board_data: board_data, board_size: board_size} =
      board_spec

    board_data
    |> Map.replace!(position_to_update, player_symbol)
    |> new_struct(board_size)
  end

  def has_empty_spaces?(board) do
    board
    |> Map.values()
    |> Enum.any?(fn value -> value == " " end)
  end

  def is_a_empty_space(board_position, board) do
    board[board_position] == " "
  end

  def convert_horizontal_to_row(board_spec) do
    %Board{board_data: board, board_size: board_size} = board_spec

    board
    |> Map.values()
    |> Enum.chunk_every(board_size)
  end

  def convert_vertical_to_row(board_spec) do
    %Board{board_data: board, board_size: board_size} = board_spec

    1..board_size
    |> Enum.map(fn row_idx ->
      generate_row_values(row_idx..max_spaces(board_size), board_size, board_size, board)
    end)
  end

  def convert_diagonal_to_row(board_spec) do
    %Board{board_data: board, board_size: board_size} = board_spec
    [
      generate_row_values(1..max_spaces(board_size), board_size + 1, board_size, board),
      generate_row_values(board_size..max_spaces(board_size), board_size - 1, board_size, board)
    ]
  end

  def generate_row_values(range, num_to_take, board_size, board) do
    range
    |> Enum.take_every(num_to_take)
    |> Enum.take(board_size)
    |> Enum.map(fn row -> board[row] end)
  end

  def generate_board_data(board_size) do
    1..(board_size * board_size)
    |> Enum.reduce(%{}, fn num, acc -> Map.put(acc, num, " ") end)
  end

  def new_struct(new_board_data, new_board_size \\ 3) do
    existing_board = %Board{}

    %Board{
      existing_board
      | board_data: new_board_data,
        board_size: new_board_size
    }
  end
end
