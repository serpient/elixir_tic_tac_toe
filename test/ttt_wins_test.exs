defmodule TTT_Check_For_Wins_Test do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest TTT
  doctest GameOutput
  doctest CheckForWins

  test "Player X wins if they have 3 matching horizontal symbols" do
    initial_board = %{
      1 => "X",
      2 => "X",
      3 => "X",
      4 => " ",
      5 => " ",
      6 => " ",
      7 => " ",
      8 => " ",
      9 => " "
    }
    assert CheckForWins.analyze(initial_board) == {:ok, :wins_game}
  end
end
