defmodule Board do
  def handle_board_update(result, state, player_symbol) do
    case result do
      {:ok, position_to_update} -> {:ok, BoardState.update_board(position_to_update, state, player_symbol)}
      {:error, _message} -> result
    end
  end

  def is_full?(state) do
    state
    |> BoardState.all_positions()
    |> Enum.all?(fn value -> value != :empty end)
  end

  def is_position_empty?(board_position, board) do
    board[board_position] == :empty
  end

  def horizontal_rows(state) do
    state
    |> BoardState.all_positions()
    |> Enum.chunk_every(BoardState.size(state))
  end

  def vertical_rows(state) do
    board_size = BoardState.size(state)
    board = BoardState.board(state)
    max_spaces = BoardState.max_spaces(state)

    for row_idx <- 1..board_size do
      generate_row_values(row_idx..max_spaces, board_size, board_size, board)
    end
  end

  def diagonal_rows(state) do
    board_size = BoardState.size(state)
    board = BoardState.board(state)
    max_spaces = BoardState.max_spaces(state)
    top_left_corner_idx = 1
    top_right_corner_idx = board_size

    [
      generate_row_values(top_left_corner_idx..max_spaces, board_size + 1, board_size, board),
      generate_row_values(top_right_corner_idx..max_spaces, board_size - 1, board_size, board)
    ]
  end

  defp generate_row_values(range, num_to_take, board_size, board) do
    range
    |> Enum.take_every(num_to_take)
    |> Enum.take(board_size)
    |> Enum.map(fn row -> board[row] end)
  end

  def generate_board_data(board_size) do
    1..(board_size * board_size)
    |> BoardState.new_board()
  end
end
