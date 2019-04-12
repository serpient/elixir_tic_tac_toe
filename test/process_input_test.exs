defmodule Process_Input_Test do
  use ExUnit.Case
  doctest TicTacToe
  doctest GameIO
  doctest ProcessInput

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

    initial_board_spec = BoardState.new_state(initial_board, 3)

    assert ProcessInput.handle_input("1", initial_board_spec) == {:ok, 1}
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

    initial_board_spec = BoardState.new_state(initial_board, 3)

    assert ProcessInput.handle_input("4", initial_board_spec) == {:ok, 4}
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

    error_board_spec = BoardState.new_state(board_with_error_input, 3)

    assert ProcessInput.handle_input("1", error_board_spec) ==
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

    error_board_spec = BoardState.new_state(board_with_error_input, 3)

    assert ProcessInput.handle_input("string", error_board_spec) ==
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

    error_board_spec = BoardState.new_state(board_with_error_input, 3)

    assert ProcessInput.handle_input("10", error_board_spec) ==
             {:error, :invalid_input_range}
  end

  test "[handle_input] Inputting a number NOT 1-16 on a 4x4 board returns a error tuple with correct error message" do
    error_board_spec = BoardState.new_state(%{}, 4)

    assert ProcessInput.handle_input("17", error_board_spec) ==
             {:error, :invalid_input_range}
  end

  test "[validate_board_size_input] returns 3 or 4 if valid input" do
    assert ProcessInput.validate_board_size_input(3) == {:ok, 3}
  end

  test "[validate_board_size_input] returns :error if input is not 3 or 4" do
    assert ProcessInput.validate_board_size_input(5)
        == {:error, :invalid_board_size_input}
  end

  test "[validate_board_size_input] returns :error if input is not a number" do
    assert ProcessInput.validate_board_size_input("a")
        == {:error, :invalid_board_size_input}
  end

  test "[validate_opponent_type_input] returns :ai if input is c" do
    assert ProcessInput.validate_opponent_type_input("C")
        == {:ok, :ai}
  end

  test "[validate_opponent_type_input] returns :opponent if input is l" do
    assert ProcessInput.validate_opponent_type_input("L")
        == {:ok, :opponent}
  end

  test "[validate_opponent_type_input] returns :error if input is not l or c" do
    assert ProcessInput.validate_opponent_type_input("a")
        == {:error, :invalid_opponent_type_input}
  end


  test "[handle_board_size_input] returns valid result if input is string 3" do
    assert ProcessInput.handle_board_size_input("3")
        == {:ok, 3}
  end

  test "[handle_board_size_input] returns :error if input is string 1" do
    assert ProcessInput.handle_board_size_input("1")
        == {:error, :invalid_board_size_input}
  end

  test "[handle_board_size_input] returns :error if input is string 2" do
    assert ProcessInput.handle_board_size_input("2")
        == {:error, :invalid_board_size_input}
  end

  test "[handle_opponent_type_input] returns :ok tuple if input is C of character type" do
    assert ProcessInput.handle_opponent_type_input('C\n') == {:ok, :ai}
  end
end
