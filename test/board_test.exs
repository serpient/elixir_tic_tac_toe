defmodule BoardTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest Board

  test "[handle_board_update] On :ok, updates board data and returns ok + updated data tuple" do
    initial_board = %{
      1 => :player,
      2 => :empty,
      3 => :empty
    }

    initial_board_state = BoardState.new_state(initial_board, 3)

    updated_board = %{
      1 => :player,
      2 => :empty,
      3 => :opponent
    }

    updated_board_state = BoardState.new_state(updated_board, 3)

    assert Board.handle_board_update({:ok, 3}, initial_board_state, :opponent) ==
             {:ok, updated_board_state}
  end

  test "[handle_board_update] On :error, returns the error tuple" do
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

    initial_board_state = BoardState.new_state(initial_board, 3)

    assert Board.handle_board_update({:error, :invalid_input}, initial_board_state, "X") ==
             {:error, :invalid_input}
  end

  test "[is_full] Returns true if board is filled." do
    has_no_empty_spaces_board = %{
      1 => :player,
      2 => :opponent,
      3 => :player
    }

    initial_board_state = BoardState.new_state(has_no_empty_spaces_board, 3)

    assert Board.is_full?(initial_board_state) == true
  end

  test "[is_full] Returns false if board has more spaces to play." do
    is_full_board = %{
      1 => :player,
      2 => :opponent,
      3 => :empty
    }

    initial_board_state = BoardState.new_state(is_full_board, 3)

    assert Board.is_full?(initial_board_state) == false
  end

  test "[is_position_empty?] Returns false if position has player symbol." do
    space_is_already_taken_board = %{
      1 => :player,
      2 => :empty,
      3 => :empty
    }

    assert Board.is_position_empty?(1, space_is_already_taken_board) == false
  end

  test "[is_position_empty?] Returns true if position has no player symbol." do
    space_is_not_taken_board = %{
      1 => :opponent,
      2 => :empty,
      3 => :empty
    }

    assert Board.is_position_empty?(2, space_is_not_taken_board) == true
  end

  test "[horizontal_rows] Converts 3x3 board correctly" do
    initial_board = %{
      1 => "1",
      2 => "2",
      3 => "3",
      4 => "4",
      5 => "5",
      6 => "6",
      7 => "7",
      8 => "8",
      9 => "9"
    }

    horizontal_conversion_board_state = %BoardState{
      board_data: initial_board
    }

    assert Board.horizontal_rows(horizontal_conversion_board_state) == [
             ["1", "2", "3"],
             ["4", "5", "6"],
             ["7", "8", "9"]
           ]
  end

  test "[horizontal_rows] Converts 4x4 board correctly" do
    new_4x4_board = %{
      1 => "1",
      2 => "2",
      3 => "3",
      4 => "4",
      5 => "5",
      6 => "6",
      7 => "7",
      8 => "8",
      9 => "9",
      10 => "10",
      11 => "11",
      12 => "12",
      13 => "13",
      14 => "14",
      15 => "15",
      16 => "16"
    }

    horizontal_conversion_board_state = BoardState.new_state(new_4x4_board, 4)

    assert Board.horizontal_rows(horizontal_conversion_board_state) == [
             ["1", "2", "3", "4"],
             ["5", "6", "7", "8"],
             ["9", "10", "11", "12"],
             ["13", "14", "15", "16"]
           ]
  end

  test "[vertical_rows] Converts 3x3 board correctly" do
    new_3x3_board = %{
      1 => "1",
      2 => "2",
      3 => "3",
      4 => "4",
      5 => "5",
      6 => "6",
      7 => "7",
      8 => "8",
      9 => "9"
    }

    vertical_conversion_board_state = BoardState.new_state(new_3x3_board, 3)

    assert Board.vertical_rows(vertical_conversion_board_state) == [
             ["1", "4", "7"],
             ["2", "5", "8"],
             ["3", "6", "9"]
           ]
  end

  test "[vertical_rows] Converts 4x4 board correctly" do
    new_4x4_board = %{
      1 => "1",
      2 => "2",
      3 => "3",
      4 => "4",
      5 => "5",
      6 => "6",
      7 => "7",
      8 => "8",
      9 => "9",
      10 => "10",
      11 => "11",
      12 => "12",
      13 => "13",
      14 => "14",
      15 => "15",
      16 => "16"
    }

    vertical_conversion_board_state = BoardState.new_state(new_4x4_board, 4)

    assert Board.vertical_rows(vertical_conversion_board_state) == [
             ["1", "5", "9", "13"],
             ["2", "6", "10", "14"],
             ["3", "7", "11", "15"],
             ["4", "8", "12", "16"]
           ]
  end

  test "[diagonal_rows] Converts board correctly" do
    initial_board = %{
      1 => "1",
      2 => "2",
      3 => "3",
      4 => "4",
      5 => "5",
      6 => "6",
      7 => "7",
      8 => "8",
      9 => "9"
    }

    diagonal_conversion_board_state = %BoardState{
      board_data: initial_board
    }

    assert Board.diagonal_rows(diagonal_conversion_board_state) == [
             ["1", "5", "9"],
             ["3", "5", "7"]
           ]
  end

  test "[diagonal_rows] Converts 4x4 board correctly" do
    new_4x4_board = %{
      1 => "1",
      2 => "2",
      3 => "3",
      4 => "4",
      5 => "5",
      6 => "6",
      7 => "7",
      8 => "8",
      9 => "9",
      10 => "10",
      11 => "11",
      12 => "12",
      13 => "13",
      14 => "14",
      15 => "15",
      16 => "16"
    }

    diagonal_conversion_board_state = BoardState.new_state(new_4x4_board, 4)

    assert Board.diagonal_rows(diagonal_conversion_board_state) == [
             ["1", "6", "11", "16"],
             ["4", "7", "10", "13"]
           ]
  end

  test "[generate_board_data] Generates 4x4 board data" do
    new_4x4_board = %{
      1 => :empty,
      3 => :empty,
      2 => :empty,
      4 => :empty,
      5 => :empty,
      6 => :empty,
      7 => :empty,
      8 => :empty,
      9 => :empty,
      10 => :empty,
      11 => :empty,
      12 => :empty,
      13 => :empty,
      14 => :empty,
      15 => :empty,
      16 => :empty
    }

    assert Board.generate_board_data(4) == new_4x4_board
  end

  test "[generate_board_data] Generates default 3x3 board data" do
    new_3x3_board = %{
      1 => :empty,
      2 => :empty,
      3 => :empty,
      4 => :empty,
      5 => :empty,
      6 => :empty,
      7 => :empty,
      8 => :empty,
      9 => :empty
    }

    assert Board.generate_board_data(3) == new_3x3_board
  end
end
