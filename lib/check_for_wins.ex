defmodule CheckForWins do
  def is_row_a_win?(row_data, player_symbol) do
    Enum.all?(row_data, fn symbol -> symbol == player_symbol end)
  end

  def has_winning_row?(all_rows) do
    all_rows
    |> Enum.any?(fn row -> is_row_a_win?(row, :player) || is_row_a_win?(row, :opponent) || is_row_a_win?(row, :ai) end)
  end

  def analyze(board_state) do
    horizontal_wins = Board.horizontal_rows(board_state) |> has_winning_row?

    vertical_wins = Board.vertical_rows(board_state) |> has_winning_row?

    diagonal_wins = Board.diagonal_rows(board_state) |> has_winning_row?

    cond do
      Enum.any?([horizontal_wins, vertical_wins, diagonal_wins]) -> {:ok, :wins_game, board_state}
      Board.is_full?(board_state) -> {:error, :game_is_a_tie, board_state}
      true -> {:ok, :no_win, board_state}
    end
  end

  def check_for_win(result, board_state) do
    {result_code, result_value} = result

    case result_code do
      :ok -> analyze(result_value)
      :error -> Tuple.append(result, board_state)
    end
  end
end
