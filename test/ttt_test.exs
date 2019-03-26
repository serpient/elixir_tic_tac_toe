defmodule TTT_Play_Test do
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

  test "After board is filled, don't allow more input and outputs message." do
    initial_board = %{
      1 => "X",
      2 => "O",
      3 => "X",
      4 => "O",
      5 => "X",
      6 => "O",
      7 => "X",
      8 => "O",
      9 => "X"
    }

    assert capture_io(fn -> TTT.play(initial_board, nil, "O") end) ==
             GameOutput.get_message(:board_is_filled) <> "\n"
  end

  test "Checks for empty spots in board. False is filled." do
    initial_board = %{
      1 => "X",
      2 => "O",
      3 => "X",
      4 => "O",
      5 => "X",
      6 => "O",
      7 => "X",
      8 => "O",
      9 => "X"
    }

    assert TTT.check_for_empty_spaces(initial_board) == false
  end

  test "Returns true if there is still empty spots in board." do
    initial_board = %{
      1 => "X",
      2 => "O",
      3 => "X",
      4 => "O",
      5 => "X",
      6 => "O",
      7 => "X",
      8 => "O",
      9 => " "
    }

    assert TTT.check_for_empty_spaces(initial_board) == true
  end

  test "Toggles player symbols." do
    assert TTT.get_other_player_symbol("X") == "O"
  end
end
