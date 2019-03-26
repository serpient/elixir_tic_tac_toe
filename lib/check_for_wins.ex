defmodule CheckForWins do
  def check_row(row_data, player_symbol) do
    Enum.all?(row_data, fn symbol -> symbol == player_symbol end)
  end
  def analyze(board) do
    wins = Map.values(board)
    |> Enum.chunk_every(3)
    |> Enum.map(fn (row) -> check_row(row, "X") || check_row(row, "O") end)
    cond do
      Enum.member?(wins, true) -> {:ok, :wins_game}
      true -> {:error, :no_win}
    end
  end
end
