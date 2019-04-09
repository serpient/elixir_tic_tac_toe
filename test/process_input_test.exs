defmodule Process_Input_Test do
  use ExUnit.Case
  doctest TicTacToe
  doctest GameIO
  doctest ProcessInput

  test "[handle_input] On valid input to empty board, returns a ok tuple with converted value" do
    initial_board = %{
      1 => " ",
      2 => " ",
      3 => " ",
      4 => " ",
      5 => " ",
      6 => " ",
      7 => " ",
      8 => " ",
      9 => " "
    }

    initial_board_spec = Board.update_board_spec(initial_board)

    assert ProcessInput.handle_input("1", initial_board_spec) == {:ok, 1}
  end

  test "[handle_input] On valid input to non-empty board, returns a ok tuple with converted value" do
    initial_board = %{
      1 => "X",
      2 => " ",
      3 => " ",
      4 => " ",
      5 => " ",
      6 => " ",
      7 => " ",
      8 => " ",
      9 => " "
    }

    initial_board_spec = Board.update_board_spec(initial_board)

    assert ProcessInput.handle_input("4", initial_board_spec) == {:ok, 4}
  end

  test "[handle_input] On overlapping input, returns error tuple with correct error message" do
    board_with_error_input = %{
      1 => "X",
      2 => " ",
      3 => " ",
      4 => " ",
      5 => " ",
      6 => " ",
      7 => " ",
      8 => " ",
      9 => " "
    }

    error_board_spec = Board.update_board_spec(board_with_error_input)

    assert ProcessInput.handle_input("1", error_board_spec) ==
             {:error, :duplicate_input}
  end

  test "[handle_input] After non-number input, returns error tuple with correct error message" do
    board_with_error_input = %{
      1 => "X",
      2 => " ",
      3 => " ",
      4 => " ",
      5 => " ",
      6 => " ",
      7 => " ",
      8 => " ",
      9 => " "
    }

    error_board_spec = Board.update_board_spec(board_with_error_input)

    assert ProcessInput.handle_input("string", error_board_spec) ==
             {:error, :invalid_input}
  end

  test "[handle_input] Inputting a number NOT 1-9 on a 3x3 board returns a error tuple with correct error message" do
    board_with_error_input = %{
      1 => " ",
      2 => " ",
      3 => " ",
      4 => " ",
      5 => " ",
      6 => " ",
      7 => " ",
      8 => " ",
      9 => " "
    }

    error_board_spec = Board.update_board_spec(board_with_error_input)

    assert ProcessInput.handle_input("10", error_board_spec) ==
             {:error, :invalid_input_range}
  end


  test "[handle_input] Inputting a number NOT 1-16 on a 4x4 board returns a error tuple with correct error message" do
    error_board_spec = Board.update_board_spec(%{},4,4)

    assert ProcessInput.handle_input("17", error_board_spec) ==
             {:error, :invalid_input_range}
  end
end
