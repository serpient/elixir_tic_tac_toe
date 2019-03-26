defmodule CheckForWins do
  def analyze(board) do
    wins = Map.values(board)
    |> Enum.chunk_every(3)
    |> Enum.map(fn (row) -> (Enum.all?(row, fn symbol -> symbol == "X" end)) || (Enum.all?(row, fn symbol -> symbol == "O" end)) end)

    cond do
      Enum.member?(wins, true) -> {:ok, :wins_game}
      true -> {:no_win}
    end
  end
end
