defmodule CheckForWins do
  def check_for_win(result, state) do
    case result do
      {:ok, value} -> analyze(value)
      {:error, _message} -> Tuple.append(result, state)
    end
  end

  def analyze(state) do
    horizontal_wins = Board.horizontal_rows(state) |> has_winning_row?

    vertical_wins = Board.vertical_rows(state) |> has_winning_row?

    diagonal_wins = Board.diagonal_rows(state) |> has_winning_row?

    cond do
      Enum.any?([horizontal_wins, vertical_wins, diagonal_wins]) -> {:ok, :wins_game, state}
      Board.is_full?(state) -> {:error, :game_is_a_tie, state}
      true -> {:ok, :no_win, state}
    end
  end

  def has_winning_row?(all_rows) do
    all_rows
    |> Enum.any?(fn row -> is_row_a_win?(row) end)
  end

  def is_row_a_win?(row_data) do
    row_data
    |> Enum.all?(fn symbol -> symbol != :empty and symbol == List.first(row_data) end)
  end
end
