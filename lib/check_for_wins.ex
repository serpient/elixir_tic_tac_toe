defmodule CheckForWins do
  def is_row_a_win?(row_data, player_symbol) do
    Enum.all?(row_data, fn symbol -> symbol == player_symbol end)
  end

  def is_any_row_within_board_a_win?(row_data) do
    wins_list = Enum.map(row_data, fn row -> is_row_a_win?(row, "X") || is_row_a_win?(row, "O") end)

    cond do
      Enum.member?(wins_list, true) -> true
      true -> false
    end
  end

  def analyze(board) do
    horizontal = Board.convert_horizontal_to_row(board) |> is_any_row_within_board_a_win?

    vertical = Board.convert_vertical_to_row(board) |> is_any_row_within_board_a_win?

    diagonal = Board.convert_diagonal_to_row(board) |> is_any_row_within_board_a_win?

    board_has_win? = [horizontal, vertical, diagonal]

    cond do
      Enum.member?(board_has_win?, true) -> {:ok, :wins_game, board}
      Board.has_empty_spaces?(board) == false -> {:error, :game_is_a_tie, board}
      true -> {:ok, :no_win, board}
    end
  end

  def handle_check_for_win(result, board, _current_player) do
    {result_code, result_value} = result

    case result_code do
      :ok -> analyze(result_value)
      :error -> Tuple.append(result, board)
    end
  end
end
