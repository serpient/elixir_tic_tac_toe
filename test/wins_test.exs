defmodule Check_For_Wins_Test do
  use ExUnit.Case
  doctest TicTacToe
  doctest GameIO
  doctest CheckForWins

  test "[analyze][Horizontal Wins] Row 1 - Wins if they have 3 matching horizontal symbols" do
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

  test "[analyze][Horizontal Wins] Row 2 - Wins if they have 3 matching horizontal symbols" do
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

  test "[analyze][Horizontal Wins] No wins if no adjacent matches in row" do
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

  test "[analyze][Horizontal Wins] Row 3 - No wins if there are 3 in a row from both players" do
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

  test "[analyze][Vertical Wins] Column 1 - Wins if there are 3 matching vertical" do
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

  test "[analyze][Vertical Wins] Column 2 - Wins if there are 3 matching vertical" do
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

  test "[analyze][Vertical Wins] Column 3 - Wins if there are 3 matching vertical" do
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

  test "[analyze][Vertical Wins] Does not win if there are non-matching" do
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

  test "[analyze][Diagonal Wins] Diagonal 1 - 3 Matching Diagonal wins 1,5,9" do
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

  test "[analyze][Diagonal Wins] Diagon 2 - 3 Matching Diagonal wins 3,5,7" do
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

  test "[analyze][Diagonal Wins] Non-Matching Diagonal does not win 3,5,7" do
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

  test "[analyze][has_empty_spaces] Returns False if board is filled." do
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

  test "[analyze][has_empty_spaces] Returns True if board has more spaces to play." do
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

  test "[analyze][handle_win_check] Winning board is passed to analyze and results in ok tuple" do
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

    assert CheckForWins.handle_win_check({:ok, initial_board}, initial_board, "X") ==
             {:ok, :wins_game, initial_board}
  end

  test "[analyze][handle_win_check] Non winning board results in error tuple" do
    initial_board = %{
      1 => "X",
      2 => "X",
      3 => "O",
      4 => " ",
      5 => " ",
      6 => " ",
      7 => " ",
      8 => " ",
      9 => " "
    }

    assert CheckForWins.handle_win_check({:ok, initial_board}, initial_board, "X") ==
             {:error, :no_win, initial_board}
  end

  test "[analyze][handle_win_check] Error passed to this function results in error tuple" do
    initial_board = %{
      1 => "X",
      2 => "X",
      3 => "O",
      4 => " ",
      5 => " ",
      6 => " ",
      7 => " ",
      8 => " ",
      9 => " "
    }

    assert CheckForWins.handle_win_check({:error, :invalid_input}, initial_board, "X") ==
             {:error, :invalid_input, initial_board}
  end
end
