defmodule CheckForWins do
  def is_win?(row_data, player_symbol) do
    Enum.all?(row_data, fn symbol -> symbol == player_symbol end)
  end

  def convert_horizontal_to_row(board) do
    Map.values(board)
    |> Enum.chunk_every(3)
  end

  def convert_vertical_to_row(board) do
    Enum.map(1..3, fn row_idx -> [board[row_idx], board[row_idx + 3], board[row_idx + 6]] end)
  end

  def check_row(row_data) do
    wins_list = Enum.map(row_data, fn row -> is_win?(row, "X") || is_win?(row, "O") end)

    cond do
      Enum.member?(wins_list, true) -> {:ok, :wins_game}
      true -> {:error, :no_win}
    end
  end

  def analyze(board) do
    horizontal = convert_horizontal_to_row(board) |> check_row

    vertical = convert_vertical_to_row(board) |> check_row

    diagonal =
      Enum.map([1, 3], fn row_idx ->
        cond do
          row_idx == 1 -> [board[row_idx], board[row_idx + 4], board[row_idx + 8]]
          row_idx == 3 -> [board[row_idx], board[row_idx + 2], board[row_idx + 4]]
        end
      end)
      |> check_row

    wins_type = [horizontal, vertical, diagonal]

    cond do
      Enum.member?(wins_type, {:ok, :wins_game}) -> {:ok, :wins_game}
      true -> {:error, :no_win}
    end
  end
end
