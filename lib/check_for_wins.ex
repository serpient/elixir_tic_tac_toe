defmodule CheckForWins do
  def check_row(row_data, player_symbol) do
    Enum.all?(row_data, fn symbol -> symbol == player_symbol end)
  end
  def analyze(board) do
    horizontal_wins = Map.values(board)
    |> Enum.chunk_every(3)
    |> Enum.map(fn (row) -> check_row(row, "X") || check_row(row, "O") end)

    vertical_wins =
    Enum.map(1..3, fn row_idx -> [board[row_idx], board[row_idx + 3], board[row_idx + 6]] end)
    |> Enum.map(fn (row) -> check_row(row, "X") || check_row(row, "O") end)

    cond do
      Enum.member?(horizontal_wins, true) -> {:ok, :wins_game}
      Enum.member?(vertical_wins, true) -> {:ok, :wins_game}
      true -> {:error, :no_win}
    end
  end
end
