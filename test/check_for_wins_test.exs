defmodule Check_For_Wins_Test do
  use ExUnit.Case
  doctest TicTacToe
  doctest GameIO
  doctest CheckForWins

  test "[analyze][Horizontal Wins] Row 1 - Wins if they have 3 matching horizontal symbols" do
    horizontal_win_board = %{
      1 => :player,
      2 => :player,
      3 => :player,
      4 => :empty,
      5 => :empty,
      6 => :empty,
      7 => :empty,
      8 => :empty,
      9 => :empty
    }

    horizontal_win_board_state = %BoardState{
      board_data: horizontal_win_board
    }

    assert CheckForWins.analyze(horizontal_win_board_state) ==
             {:ok, :wins_game, horizontal_win_board_state}
  end

  test "[analyze][Horizontal Wins] Row 2 - Wins if they have 3 matching horizontal symbols" do
    horizontal_win_board = %{
      1 => :empty,
      2 => :empty,
      3 => :empty,
      4 => :opponent,
      5 => :opponent,
      6 => :opponent,
      7 => :empty,
      8 => :empty,
      9 => :empty
    }

    horizontal_win_board_state = %BoardState{
      board_data: horizontal_win_board
    }

    assert CheckForWins.analyze(horizontal_win_board_state) ==
             {:ok, :wins_game, horizontal_win_board_state}
  end

  test "[analyze][Horizontal Wins] No wins if no adjacent matches in row" do
    no_horizontal_win_board = %{
      1 => :empty,
      2 => :player,
      3 => :player,
      4 => :player,
      5 => :opponent,
      6 => :opponent,
      7 => :opponent,
      8 => :empty,
      9 => :empty
    }

    no_horizontal_win_board_state = %BoardState{
      board_data: no_horizontal_win_board
    }

    assert CheckForWins.analyze(no_horizontal_win_board_state) ==
             {:ok, :no_win, no_horizontal_win_board_state}
  end

  test "[analyze][Horizontal Wins] Row 3 - No wins if there are 3 in a row from both players" do
    no_horizontal_win_board = %{
      1 => :empty,
      2 => :empty,
      3 => :empty,
      4 => :empty,
      5 => :empty,
      6 => :empty,
      7 => :opponent,
      8 => :player,
      9 => :opponent
    }

    no_horizontal_win_board_state = %BoardState{
      board_data: no_horizontal_win_board
    }

    assert CheckForWins.analyze(no_horizontal_win_board_state) ==
             {:ok, :no_win, no_horizontal_win_board_state}
  end

  test "[analyze][Horizontal Wins] Row 2 - Wins if there are 4 in a row" do
    horizontal_win_board = %{
      1 => :empty,
      2 => :empty,
      3 => :empty,
      4 => :empty,
      5 => :opponent,
      6 => :opponent,
      7 => :opponent,
      8 => :opponent,
      9 => :empty,
      10 => :empty,
      11 => :empty,
      12 => :empty,
      13 => :empty,
      14 => :empty,
      15 => :empty,
      16 => :empty
    }

    horizontal_win_board_state = BoardState.new_state(horizontal_win_board, 4)

    assert CheckForWins.analyze(horizontal_win_board_state) ==
             {:ok, :wins_game, horizontal_win_board_state}
  end

  test "[analyze][Vertical Wins] Column 2 - Wins if there are 3 matching vertical" do
    vertical_win_board = %{
      1 => :player,
      2 => :opponent,
      3 => :empty,
      4 => :player,
      5 => :opponent,
      6 => :empty,
      7 => :empty,
      8 => :opponent,
      9 => :empty
    }

    vertical_win_board_state = %BoardState{
      board_data: vertical_win_board
    }

    assert CheckForWins.analyze(vertical_win_board_state) ==
             {:ok, :wins_game, vertical_win_board_state}
  end

  test "[analyze][Vertical Wins] Column 3 - Wins if there are 3 matching vertical" do
    vertical_win_board = %{
      1 => :empty,
      2 => :empty,
      3 => :player,
      4 => :empty,
      5 => :empty,
      6 => :player,
      7 => :empty,
      8 => :empty,
      9 => :player
    }

    vertical_win_board_state = %BoardState{
      board_data: vertical_win_board
    }

    assert CheckForWins.analyze(vertical_win_board_state) ==
             {:ok, :wins_game, vertical_win_board_state}
  end

  test "[analyze][Vertical Wins] Column 3 - Wins if there are 4 matching vertical" do
    vertical_win_board = %{
      1 => :empty,
      2 => :empty,
      3 => :empty,
      4 => :opponent,
      5 => :empty,
      6 => :empty,
      7 => :empty,
      8 => :opponent,
      9 => :empty,
      10 => :empty,
      11 => :empty,
      12 => :opponent,
      13 => :empty,
      14 => :empty,
      15 => :empty,
      16 => :opponent
    }

    vertical_win_board_state = BoardState.new_state(vertical_win_board, 4)

    assert CheckForWins.analyze(vertical_win_board_state) ==
             {:ok, :wins_game, vertical_win_board_state}
  end

  test "[analyze][Vertical Wins] Does not win if there are non-matching" do
    no_vertical_win_board = %{
      1 => :empty,
      2 => :empty,
      3 => :player,
      4 => :empty,
      5 => :empty,
      6 => :opponent,
      7 => :empty,
      8 => :empty,
      9 => :player
    }

    no_vertical_win_board_state = %BoardState{
      board_data: no_vertical_win_board
    }

    assert CheckForWins.analyze(no_vertical_win_board_state) ==
             {:ok, :no_win, no_vertical_win_board_state}
  end

  test "[analyze][Diagonal Wins] Diagonal 1 - 3 Matching Diagonal wins 1,5,9" do
    diagonal_win_board = %{
      1 => :player,
      2 => :empty,
      3 => :empty,
      4 => :empty,
      5 => :player,
      6 => :empty,
      7 => :empty,
      8 => :empty,
      9 => :player
    }

    diagonal_win_board_state = %BoardState{
      board_data: diagonal_win_board
    }

    assert CheckForWins.analyze(diagonal_win_board_state) ==
             {:ok, :wins_game, diagonal_win_board_state}
  end

  test "[analyze][Diagonal Wins] Diagon 2 - 3 Matching Diagonal wins 3,5,7" do
    diagonal_win_board = %{
      1 => :empty,
      2 => :empty,
      3 => :opponent,
      4 => :empty,
      5 => :opponent,
      6 => :empty,
      7 => :opponent,
      8 => :empty,
      9 => :empty
    }

    diagonal_win_board_state = %BoardState{
      board_data: diagonal_win_board
    }

    assert CheckForWins.analyze(diagonal_win_board_state) ==
             {:ok, :wins_game, diagonal_win_board_state}
  end

  test "[analyze][Diagonal Wins] Non-Matching Diagonal does not win 3,5,7" do
    no_diagonal_win_board = %{
      1 => :empty,
      2 => :empty,
      3 => :opponent,
      4 => :empty,
      5 => :player,
      6 => :empty,
      7 => :opponent,
      8 => :empty,
      9 => :empty
    }

    no_diagonal_win_board_state = %BoardState{
      board_data: no_diagonal_win_board
    }

    assert CheckForWins.analyze(no_diagonal_win_board_state) ==
             {:ok, :no_win, no_diagonal_win_board_state}
  end

  test "[analyze][Diagonal Wins] Wins if there are 4 matching diagonally" do
    diagonal_win_board = %{
      1 => :empty,
      2 => :empty,
      3 => :empty,
      4 => :opponent,
      5 => :empty,
      6 => :empty,
      7 => :opponent,
      8 => :empty,
      9 => :empty,
      10 => :opponent,
      11 => :empty,
      12 => :empty,
      13 => :opponent,
      14 => :empty,
      15 => :empty,
      16 => :empty
    }

    diagonal_win_board_state = BoardState.new_state(diagonal_win_board, 4)

    assert CheckForWins.analyze(diagonal_win_board_state) ==
             {:ok, :wins_game, diagonal_win_board_state}
  end

  test "[check_for_win] Winning board is passed to analyze and results in ok tuple" do
    winning_board = %{
      1 => :player,
      2 => :player,
      3 => :player,
      4 => :empty,
      5 => :empty,
      6 => :empty,
      7 => :empty,
      8 => :empty,
      9 => :empty
    }

    winning_board_state = %BoardState{
      board_data: winning_board
    }

    assert CheckForWins.check_for_win({:ok, winning_board_state}, winning_board_state) ==
             {:ok, :wins_game, winning_board_state}
  end

  test "[check_for_win] Non winning board results in :no_win tuple" do
    non_winning_board = %{
      1 => :player,
      2 => :player,
      3 => :opponent,
      4 => :empty,
      5 => :empty,
      6 => :empty,
      7 => :empty,
      8 => :empty,
      9 => :empty
    }

    non_winning_board_state = %BoardState{
      board_data: non_winning_board
    }

    assert CheckForWins.check_for_win(
             {:ok, non_winning_board_state},
             non_winning_board_state
           ) == {:ok, :no_win, non_winning_board_state}
  end

  test "[check_for_win] Error tuple passed to this function results in another error tuple" do
    board_with_error = %{
      1 => :player,
      2 => :player,
      3 => :opponent,
      4 => :empty,
      5 => :empty,
      6 => :empty,
      7 => :empty,
      8 => :empty,
      9 => :empty
    }

    assert CheckForWins.check_for_win({:error, :invalid_input}, board_with_error) ==
             {:error, :invalid_input, board_with_error}
  end

  test "[check_for_win] Winning computer board results in :wins_game" do
    winning_computer_board = %{
      1 => :ai,
      2 => :ai,
      3 => :ai,
      4 => :empty,
      5 => :empty,
      6 => :empty,
      7 => :empty,
      8 => :empty,
      9 => :empty
    }

    winning_computer_board_state = %BoardState{
      board_data: winning_computer_board
    }

    assert CheckForWins.check_for_win(
             {:ok, winning_computer_board_state},
             winning_computer_board_state
           ) == {:ok, :wins_game, winning_computer_board_state}
  end


  test "[is_row_a_win?] Returns true if every symbol in list matches current player symbol" do
    assert CheckForWins.is_row_a_win?([:player, :player, :player]) == true
  end

  test "[is_row_a_win?] Returns false if every symbol in list does not match current player symbol" do
    assert CheckForWins.is_row_a_win?([:player, :empty, :player]) == false
  end

  test "[is_row_a_win?] Returns true if every symbol in list matches :ai" do
    assert CheckForWins.is_row_a_win?([:ai, :ai, :ai]) == true
  end

  test "[has_winning_row?] Checks each row in data and returns true if there is at least a single winning row" do
    board_data_split_by_row = [
      [:player, :opponent, :player],
      [:opponent, :player, :opponent],
      [:player, :player, :player]
    ]

    assert CheckForWins.has_winning_row?(board_data_split_by_row) == true
  end

  test "[has_winning_row?] Checks each row in data and returns false if there is no winning row" do
    board_data_split_by_row = [
      [:player, :opponent, :player],
      [:opponent, :player, :opponent],
      [:player, :opponent, :player]
    ]

    assert CheckForWins.has_winning_row?(board_data_split_by_row) == false
  end
end
