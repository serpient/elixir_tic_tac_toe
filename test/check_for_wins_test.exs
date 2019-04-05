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

    assert CheckForWins.analyze(initial_board) == {:ok, :no_win, initial_board}
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

    assert CheckForWins.analyze(initial_board) == {:ok, :no_win, initial_board}
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

    assert CheckForWins.analyze(initial_board) == {:ok, :no_win, initial_board}
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

    assert CheckForWins.analyze(initial_board) == {:ok, :no_win, initial_board}
  end

  test "[handle_win_check] Winning board is passed to analyze and results in ok tuple" do
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

  test "[handle_win_check] Non winning board results in error tuple" do
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
             {:ok, :no_win, initial_board}
  end

  test "[handle_win_check] Error passed to this function results in error tuple" do
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

  test "[is_win?] Returns true if every symbol in list matches current player symbol" do
    assert CheckForWins.is_win?(["X", "X", "X"], "X") == true
  end

  test "[is_win?] Returns false if every symbol in list does not match current player symbol" do
    assert CheckForWins.is_win?(["X", "X", "X"], "O") == false
  end

  test "[check_row] Checks each row in data and returns true if there is at least a single winning row" do
    row = [["X", "O", "X"], ["O", "X", "O"], ["X", "X", "X"]]
    assert CheckForWins.check_row(row) == true
  end

  test "[check_row] Checks each row in data and returns false if there is no winning row" do
    row = [["X", "O", "X"], ["O", "X", "O"], ["X", "O", "X"]]
    assert CheckForWins.check_row(row) == false
  end
end
