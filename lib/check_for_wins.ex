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

  def convert_diagonal_to_row(board) do
    Enum.map([1, 3], fn row_idx ->
      cond do
        row_idx == 1 -> [board[row_idx], board[row_idx + 4], board[row_idx + 8]]
        row_idx == 3 -> [board[row_idx], board[row_idx + 2], board[row_idx + 4]]
      end
    end)
  end

  def check_row(row_data) do
    wins_list = Enum.map(row_data, fn row -> is_win?(row, "X") || is_win?(row, "O") end)

    cond do
      Enum.member?(wins_list, true) -> true
      true -> false
    end
  end

  def analyze(results) do
    {_status, board} = results
    horizontal = convert_horizontal_to_row(board) |> check_row

    vertical = convert_vertical_to_row(board) |> check_row

    diagonal = convert_diagonal_to_row(board) |> check_row

    board_has_win? = [horizontal, vertical, diagonal]

    cond do
      Enum.member?(board_has_win?, true) -> {:ok, :wins_game, board}
      true -> {:error, :no_win, board}
    end
  end
end
