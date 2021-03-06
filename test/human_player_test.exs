defmodule HumanPlayerTest do
  use ExUnit.Case
  doctest HumanPlayer

  test "[handle_input] On valid input to empty board, returns a ok tuple with converted value" do
    initial_board = %{
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

    initial_board_state = BoardState.new_state(initial_board, 3)

    assert HumanPlayer.handle_input("1", initial_board_state) == {:ok, 1}
  end

  test "[handle_input] On valid input to non-empty board, returns a ok tuple with converted value" do
    initial_board = %{
      1 => :player,
      2 => :empty,
      3 => :empty,
      4 => :empty,
      5 => :empty,
      6 => :empty,
      7 => :empty,
      8 => :empty,
      9 => :empty
    }

    initial_board_state = BoardState.new_state(initial_board, 3)

    assert HumanPlayer.handle_input("4", initial_board_state) == {:ok, 4}
  end

  test "[handle_input] On overlapping input, returns error tuple with correct error message" do
    board_with_error_input = %{
      1 => :player,
      2 => :empty,
      3 => :empty,
      4 => :empty,
      5 => :empty,
      6 => :empty,
      7 => :empty,
      8 => :empty,
      9 => :empty
    }

    error_board_state = BoardState.new_state(board_with_error_input, 3)

    assert HumanPlayer.handle_input("1", error_board_state) ==
             {:error, :duplicate_input}
  end

  test "[handle_input] After non-number input, returns error tuple with correct error message" do
    board_with_error_input = %{
      1 => :player,
      2 => :empty,
      3 => :empty,
      4 => :empty,
      5 => :empty,
      6 => :empty,
      7 => :empty,
      8 => :empty,
      9 => :empty
    }

    error_board_state = BoardState.new_state(board_with_error_input, 3)

    assert HumanPlayer.handle_input("string", error_board_state) ==
             {:error, :invalid_input}
  end

  test "[handle_input] Inputting a number NOT 1-9 on a 3x3 board returns a error tuple with correct error message" do
    board_with_error_input = %{
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

    error_board_state = BoardState.new_state(board_with_error_input, 3)

    assert HumanPlayer.handle_input("10", error_board_state) ==
             {:error, :invalid_input_range}
  end

  test "[handle_input] Inputting a number NOT 1-16 on a 4x4 board returns a error tuple with correct error message" do
    error_board_state = BoardState.new_state(%{}, 4)

    assert HumanPlayer.handle_input("17", error_board_state) ==
             {:error, :invalid_input_range}
  end
end
