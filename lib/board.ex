defmodule Board do
  def handle_board_update(result, board_spec, player_symbol) do
    {status, position_to_update} = result

    case status do
      :ok -> {:ok, BoardState.update_board(position_to_update, board_spec, player_symbol)}
      :error -> result
    end
  end

  def has_empty_spaces?(board) do
    board
    |> Map.values()
    |> Enum.any?(fn value -> value == " " end)
  end

  def is_a_empty_space(board_position, board) do
    board[board_position] == " "
  end

  def convert_horizontal_to_row(board_state) do
    BoardState.board(board_state)
    |> Map.values()
    |> Enum.chunk_every(BoardState.size(board_state))
  end

  def convert_vertical_to_row(board_state) do
    board_size = BoardState.size(board_state)
    board = BoardState.board(board_state)
    max_spaces = BoardState.max_spaces(board_state)
    1..board_size
    |> Enum.map(fn row_idx ->
      generate_row_values(row_idx..max_spaces, board_size, board_size, board)
    end)
  end

  def convert_diagonal_to_row(board_state) do
    board_size = BoardState.size(board_state)
    board = BoardState.board(board_state)
    max_spaces = BoardState.max_spaces(board_state)
    top_left_corner_idx = 1
    top_right_corner_idx = board_size
    [
      generate_row_values(top_left_corner_idx..max_spaces, board_size + 1, board_size, board),
      generate_row_values(top_right_corner_idx..max_spaces, board_size - 1, board_size, board)
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
    |> BoardState.new_board
  end
end
