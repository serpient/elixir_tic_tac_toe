defmodule Check_For_Wins_Test do
  use ExUnit.Case
  doctest TicTacToe
  doctest GameIO
  doctest CheckForWins

  test "[Horizontal Wins] Player X wins if they have 3 matching horizontal symbols" do
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

    assert CheckForWins.analyze(initial_board) == {:ok, :wins_game, initial_board}
  end

  test "[Horizontal Wins] Player O wins if they have 3 matching horizontal symbols" do
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

    assert CheckForWins.analyze(initial_board) == {:ok, :wins_game, initial_board}
  end

  test "[Horizontal Wins] No wins if no adjacent matches in row" do
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

    assert CheckForWins.analyze(initial_board) == {:error, :no_win, initial_board}
  end

  test "[Horizontal Wins] No wins if there are 3 in a row from both players" do
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

    assert CheckForWins.analyze(initial_board) == {:error, :no_win, initial_board}
  end

  test "[Vertical Wins] Player X Wins if there are 3 matching vertical" do
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

    assert CheckForWins.analyze(initial_board) == {:ok, :wins_game, initial_board}
  end

  test "[Vertical Wins] Player O Wins if there are 3 matching vertical" do
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

    assert CheckForWins.analyze(initial_board) == {:ok, :wins_game, initial_board}
  end

  test "[Vertical Wins] 3 matching in last column wins" do
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

    assert CheckForWins.analyze(initial_board) == {:ok, :wins_game, initial_board}
  end

  test "[Vertical Wins] Does not win if there are non-matching" do
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

    assert CheckForWins.analyze(initial_board) == {:error, :no_win, initial_board}
  end

  test "[Diagonal Wins] 3 Matching Diagonal wins 1,5,9" do
    initial_board = %{
      1 => "X",
      2 => " ",
      3 => " ",
      4 => " ",
      5 => "X",
      6 => " ",
      7 => " ",
      8 => " ",
      9 => "X"
    }

    assert CheckForWins.analyze(initial_board) == {:ok, :wins_game, initial_board}
  end

  test "[Diagonal Wins] 3 Matching Diagonal wins 3,5,7" do
    initial_board = %{
      1 => " ",
      2 => " ",
      3 => "O",
      4 => " ",
      5 => "O",
      6 => " ",
      7 => "O",
      8 => " ",
      9 => " "
    }

    assert CheckForWins.analyze(initial_board) == {:ok, :wins_game, initial_board}
  end

  test "[Diagonal Wins] Non-Matching Diagonal does not win 3,5,7" do
    initial_board = %{
      1 => " ",
      2 => " ",
      3 => "O",
      4 => " ",
      5 => "X",
      6 => " ",
      7 => "O",
      8 => " ",
      9 => " "
    }

    assert CheckForWins.analyze(initial_board) == {:error, :no_win, initial_board}
  end

  test "Checks for empty spots in board. False is filled." do
    initial_board = %{
      1 => "X",
      2 => "O",
      3 => "X",
      4 => "O",
      5 => "X",
      6 => "O",
      7 => "X",
      8 => "O",
      9 => "X"
    }

    assert CheckForWins.has_empty_spaces?(initial_board) == false
  end

  test "Returns true if there is still empty spots in board." do
    initial_board = %{
      1 => "X",
      2 => "O",
      3 => "X",
      4 => "O",
      5 => "X",
      6 => "O",
      7 => "X",
      8 => "O",
      9 => " "
    }

    assert CheckForWins.has_empty_spaces?(initial_board) == true
  end
end
