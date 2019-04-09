defmodule Check_For_Wins_Test do
  use ExUnit.Case
  doctest TicTacToe
  doctest GameIO
  doctest CheckForWins

  test "[analyze][Horizontal Wins] Row 1 - Wins if they have 3 matching horizontal symbols" do
    horizontal_win_board = %{
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

    horizontal_win_board_spec = %Board{
      board_data: horizontal_win_board,
    }

    assert CheckForWins.analyze(horizontal_win_board_spec) == {:ok, :wins_game, horizontal_win_board_spec}
  end

  test "[analyze][Horizontal Wins] Row 2 - Wins if they have 3 matching horizontal symbols" do
    horizontal_win_board = %{
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

    horizontal_win_board_spec = %Board{
      board_data: horizontal_win_board,
    }

    assert CheckForWins.analyze(horizontal_win_board_spec) == {:ok, :wins_game, horizontal_win_board_spec}
  end

  test "[analyze][Horizontal Wins] No wins if no adjacent matches in row" do
    no_horizontal_win_board = %{
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

    no_horizontal_win_board_spec = %Board{
      board_data: no_horizontal_win_board,
    }

    assert CheckForWins.analyze(no_horizontal_win_board_spec) == {:ok, :no_win, no_horizontal_win_board_spec}
  end

  test "[analyze][Horizontal Wins] Row 3 - No wins if there are 3 in a row from both players" do
    no_horizontal_win_board = %{
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

    no_horizontal_win_board_spec = %Board{
      board_data: no_horizontal_win_board,
    }

    assert CheckForWins.analyze(no_horizontal_win_board_spec) == {:ok, :no_win, no_horizontal_win_board_spec}
  end

  test "[analyze][Vertical Wins] Column 1 - Wins if there are 3 matching vertical" do
    vertical_win_board = %{
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

    vertical_win_board_spec = %Board{
      board_data: vertical_win_board,
    }

    assert CheckForWins.analyze(vertical_win_board_spec) == {:ok, :wins_game, vertical_win_board_spec}
  end

  test "[analyze][Vertical Wins] Column 2 - Wins if there are 3 matching vertical" do
    vertical_win_board = %{
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

    vertical_win_board_spec = %Board{
      board_data: vertical_win_board,
    }

    assert CheckForWins.analyze(vertical_win_board_spec) == {:ok, :wins_game, vertical_win_board_spec}
  end

  test "[analyze][Vertical Wins] Column 3 - Wins if there are 3 matching vertical" do
    vertical_win_board = %{
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

    vertical_win_board_spec = %Board{
      board_data: vertical_win_board,
    }

    assert CheckForWins.analyze(vertical_win_board_spec) == {:ok, :wins_game, vertical_win_board_spec}
  end

  test "[analyze][Vertical Wins] Does not win if there are non-matching" do
    no_vertical_win_board = %{
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

    no_vertical_win_board_spec = %Board{
      board_data: no_vertical_win_board,
    }

    assert CheckForWins.analyze(no_vertical_win_board_spec) == {:ok, :no_win, no_vertical_win_board_spec}
  end

  test "[analyze][Diagonal Wins] Diagonal 1 - 3 Matching Diagonal wins 1,5,9" do
    diagonal_win_board = %{
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

    diagonal_win_board_spec = %Board{
      board_data: diagonal_win_board,
    }

    assert CheckForWins.analyze(diagonal_win_board_spec) == {:ok, :wins_game, diagonal_win_board_spec}
  end

  test "[analyze][Diagonal Wins] Diagon 2 - 3 Matching Diagonal wins 3,5,7" do
    diagonal_win_board = %{
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

    diagonal_win_board_spec = %Board{
      board_data: diagonal_win_board,
    }

    assert CheckForWins.analyze(diagonal_win_board_spec) == {:ok, :wins_game, diagonal_win_board_spec}
  end

  test "[analyze][Diagonal Wins] Non-Matching Diagonal does not win 3,5,7" do
    no_diagonal_win_board = %{
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

    no_diagonal_win_board_spec = %Board{
      board_data: no_diagonal_win_board,
    }

    assert CheckForWins.analyze(no_diagonal_win_board_spec) == {:ok, :no_win, no_diagonal_win_board_spec}
  end

  test "[check_for_win] Winning board is passed to analyze and results in ok tuple" do
    winning_board = %{
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

    winning_board_spec = %Board{
      board_data: winning_board,
    }

    assert CheckForWins.check_for_win({:ok, winning_board_spec}, winning_board_spec, "X") ==
             {:ok, :wins_game, winning_board_spec}
  end

  test "[check_for_win] Non winning board results in :no_win tuple" do
    non_winning_board = %{
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

    non_winning_board_spec = %Board{
      board_data: non_winning_board,
    }

    assert CheckForWins.check_for_win({:ok, non_winning_board_spec}, non_winning_board_spec, "X") ==
             {:ok, :no_win, non_winning_board_spec}
  end

  test "[check_for_win] Error tuple passed to this function results in another error tuple" do
    board_with_error = %{
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

    assert CheckForWins.check_for_win({:error, :invalid_input}, board_with_error, "X") ==
             {:error, :invalid_input, board_with_error}
  end

  test "[is_row_a_win?] Returns true if every symbol in list matches current player symbol" do
    assert CheckForWins.is_row_a_win?(["X", "X", "X"], "X") == true
  end

  test "[is_row_a_win?] Returns false if every symbol in list does not match current player symbol" do
    assert CheckForWins.is_row_a_win?(["X", "X", "X"], "O") == false
  end

  test "[is_any_row_within_board_a_win?] Checks each row in data and returns true if there is at least a single winning row" do
    board_data_split_by_row = [["X", "O", "X"], ["O", "X", "O"], ["X", "X", "X"]]
    assert CheckForWins.is_any_row_within_board_a_win?(board_data_split_by_row) == true
  end

  test "[is_any_row_within_board_a_win?] Checks each row in data and returns false if there is no winning row" do
    board_data_split_by_row = [["X", "O", "X"], ["O", "X", "O"], ["X", "O", "X"]]
    assert CheckForWins.is_any_row_within_board_a_win?(board_data_split_by_row) == false
  end
end
