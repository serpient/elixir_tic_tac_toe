defmodule Board_Test do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest Board

  test "[handle_board_update] On :ok, updates board data and returns ok + updated data tuple" do
    initial_board = %{
      1 => :player,
      2 => :empty,
      3 => :empty
    }

    initial_board_spec = BoardState.new_state(initial_board, 3)

    updated_board = %{
      1 => :player,
      2 => :empty,
      3 => :opponent
    }

    updated_board_spec = BoardState.new_state(updated_board, 3)

    assert Board.handle_board_update({:ok, 3}, initial_board_spec, :opponent) ==
             {:ok, updated_board_spec}
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

    initial_board_spec = BoardState.new_state(initial_board, 3)

    assert Board.handle_board_update({:error, :invalid_input}, initial_board_spec, "X") ==
             {:error, :invalid_input}
  end

  test "[has_empty_spaces] Returns False if board is filled." do
    has_no_empty_spaces_board = %{
      1 => :player,
      2 => :opponent,
      3 => :player
    }

    initial_board_spec = BoardState.new_state(has_no_empty_spaces_board, 3)

    assert Board.has_empty_spaces?(initial_board_spec) == false
  end

  test "[has_empty_spaces] Returns True if board has more spaces to play." do
    has_empty_spaces_board = %{
      1 => :player,
      2 => :opponent,
      3 => :empty
    }

    initial_board_spec = BoardState.new_state(has_empty_spaces_board, 3)

    assert Board.has_empty_spaces?(initial_board_spec) == true
  end

  test "[is_a_empty_space] Returns false if position has player symbol." do
    space_is_already_taken_board = %{
      1 => :player,
      2 => :empty,
      3 => :empty
    }

    assert Board.is_a_empty_space(1, space_is_already_taken_board) == false
  end

  test "[is_a_empty_space] Returns true if position has no player symbol." do
    space_is_not_taken_board = %{
      1 => :opponent,
      2 => :empty,
      3 => :empty
    }

    assert Board.is_a_empty_space(2, space_is_not_taken_board) == true
  end

  test "[convert_horizontal_to_row] Converts 3x3 board correctly" do
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

    horizontal_conversion_board_spec = %BoardState{
      board_data: initial_board
    }

    assert Board.convert_horizontal_to_row(horizontal_conversion_board_spec) == [
             ["1", "2", "3"],
             ["4", "5", "6"],
             ["7", "8", "9"]
           ]
  end

  test "[convert_horizontal_to_row] Converts 4x4 board correctly" do
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

    horizontal_conversion_board_spec = BoardState.new_state(new_4x4_board, 4)

    assert Board.convert_horizontal_to_row(horizontal_conversion_board_spec) == [
             ["1", "2", "3", "4"],
             ["5", "6", "7", "8"],
             ["9", "10", "11", "12"],
             ["13", "14", "15", "16"]
           ]
  end

  test "[convert_vertical_to_row] Converts 3x3 board correctly" do
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

    vertical_conversion_board_spec = BoardState.new_state(new_3x3_board, 3)

    assert Board.convert_vertical_to_row(vertical_conversion_board_spec) == [
             ["1", "4", "7"],
             ["2", "5", "8"],
             ["3", "6", "9"]
           ]
  end

  test "[convert_vertical_to_row] Converts 4x4 board correctly" do
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

    vertical_conversion_board_spec = BoardState.new_state(new_4x4_board, 4)

    assert Board.convert_vertical_to_row(vertical_conversion_board_spec) == [
             ["1", "5", "9", "13"],
             ["2", "6", "10", "14"],
             ["3", "7", "11", "15"],
             ["4", "8", "12", "16"]
           ]
  end

  test "[convert_diagonal_to_row] Converts board correctly" do
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

    diagonal_conversion_board_spec = %BoardState{
      board_data: initial_board
    }

    assert Board.convert_diagonal_to_row(diagonal_conversion_board_spec) == [
             ["1", "5", "9"],
             ["3", "5", "7"]
           ]
  end

  test "[convert_diagonal_to_row] Converts 4x4 board correctly" do
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

    diagonal_conversion_board_spec = BoardState.new_state(new_4x4_board, 4)

    assert Board.convert_diagonal_to_row(diagonal_conversion_board_spec) == [
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
