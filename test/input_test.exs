defmodule Process_Input_Test do
  use ExUnit.Case
  doctest TicTacToe
  doctest GameOutput
  doctest ProcessInput

  test "After Player X input, board data is updated" do
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

    updated_board = %{
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

    assert ProcessInput.handle_input("1", initial_board, "X") == {:ok, updated_board}
  end

  test "After Player O input, board data is updated" do
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

    updated_board = %{
      1 => "X",
      2 => " ",
      3 => " ",
      4 => "O",
      5 => " ",
      6 => " ",
      7 => " ",
      8 => " ",
      9 => " "
    }

    assert ProcessInput.handle_input("4", initial_board, "O") == {:ok, updated_board}
  end

  test "After overlapping input, returns error." do
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

  test "IsEmpty fn returns false if position has player symbol." do
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

    assert ProcessInput.is_empty(1, initial_board) == false
  end

  test "IsEmpty fn returns true if position has no player symbol." do
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

    assert ProcessInput.is_empty(2, initial_board) == true
  end

  test "After no number input, returns error." do
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

  test "Inputting a number NOT 1-9, will throw a error." do
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

  test "Handle Validation Result chains to Wins check" do
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

    assert ProcessInput.handle_validation_result({:ok, initial_board}, initial_board, "X") ==
             {:ok, initial_board}
  end
end
