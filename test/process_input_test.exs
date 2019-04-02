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

    assert ProcessInput.handle_input("1", initial_board, "X") == {:ok, 1}
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

    assert ProcessInput.handle_input("4", initial_board, "O") == {:ok, 4}
  end

  test "[handle_input] On overlapping input, returns error tuple with correct error message" do
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

    assert ProcessInput.handle_input("1", initial_board, "O") == {:error, :duplicate_input}
  end


  test "[handle_input] After non-number input, returns error tuple with correct error message" do
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

    assert ProcessInput.handle_input("string", initial_board, "X") == {:error, :invalid_input}
  end

  test "[handle_input] Inputting a number NOT 1-9, returns a error tuple with correct error message" do
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

    assert ProcessInput.handle_input("10", initial_board, "X") == {:error, :invalid_input_range}
  end

end
