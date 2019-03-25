defmodule TTT_Test do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest TTT
  doctest GameOutput
  doctest ProcessInput

  test "Prints 3x3 board to CL" do
    initial_board = %{
      1 => "",
      2 => "",
      3 => "",
      4 => "",
      5 => "",
      6 => "",
      7 => "",
      8 => "",
      9 => ""
    }

    assert capture_io(fn -> TTT.print_board(initial_board) end) ==
             GameOutput.get_board(initial_board) <> "\n"
  end

  # test "CL outputs starter text for game" do
  #   assert capture_io(fn -> TTT.get_player_input(:initial_player_prompt) end) ==
  #            GameOutput.get_message(:initial_player_prompt)
  # end

  test "After Player X input, board is correctly displayed with new input" do
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

  test "After Player O input, board is correctly displayed with new input" do
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

  test "After overlapping input, prompt player for another input." do
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
end
