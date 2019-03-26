defmodule TTT_Check_For_Wins_Test do
  use ExUnit.Case
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

  test "Player O wins if they have 3 matching horizontal symbols" do
    initial_board = %{
      1 => " ",
      2 => " ",
      3 => " ",
      4 => "O",
      5 => "O",
      6 => "O",
      7 => " ",
      8 => " ",
      9 => " "
    }
    assert CheckForWins.analyze(initial_board) == {:ok, :wins_game}
  end

  test "No wins if no adjacent matches in row" do
    initial_board = %{
      1 => " ",
      2 => "X",
      3 => "X",
      4 => "X",
      5 => "O",
      6 => "O",
      7 => "O",
      8 => " ",
      9 => " "
    }
    assert CheckForWins.analyze(initial_board) == {:error, :no_win}
  end

  test "No wins if there are 3 in a row from both players" do
    initial_board = %{
      1 => " ",
      2 => " ",
      3 => " ",
      4 => " ",
      5 => " ",
      6 => " ",
      7 => "O",
      8 => "X",
      9 => "O"
    }
    assert CheckForWins.analyze(initial_board) == {:error, :no_win}
  end

  test "Player X Wins if there are 3 matching vertical wins" do
    initial_board = %{
      1 => "X",
      2 => " ",
      3 => " ",
      4 => "X",
      5 => " ",
      6 => " ",
      7 => "X",
      8 => " ",
      9 => " "
    }
    assert CheckForWins.analyze(initial_board) == {:ok, :wins_game}
  end

  test "Player O Wins if there are 3 matching vertical wins" do
    initial_board = %{
      1 => "X",
      2 => "O",
      3 => " ",
      4 => "X",
      5 => "O",
      6 => " ",
      7 => " ",
      8 => "O",
      9 => " "
    }
    assert CheckForWins.analyze(initial_board) == {:ok, :wins_game}
  end

  test "Wins if there are 3 matching vertical wins in last column" do
    initial_board = %{
      1 => " ",
      2 => " ",
      3 => "X",
      4 => " ",
      5 => " ",
      6 => "X",
      7 => " ",
      8 => " ",
      9 => "X"
    }
    assert CheckForWins.analyze(initial_board) == {:ok, :wins_game}
  end

  test "Does not win if there are non-matching in a column" do
    initial_board = %{
      1 => " ",
      2 => " ",
      3 => "X",
      4 => " ",
      5 => " ",
      6 => "O",
      7 => " ",
      8 => " ",
      9 => "X"
    }
    assert CheckForWins.analyze(initial_board) == {:error, :no_win}
  end
end
