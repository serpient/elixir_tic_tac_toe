defmodule Game_Output_Test do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest GameOutput

  test "Prints 3x3 board to CL" do
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

    assert capture_io(fn -> GameOutput.print_board(initial_board) end) ==
             GameOutput.get_board(initial_board) <> "\n"
  end

  test "Toggles player symbols. From X -> O" do
    assert GameOutput.get_other_player_symbol("X") == "O"
  end

  test "Toggles player symbols. From O -> X" do
    assert GameOutput.get_other_player_symbol("O") == "X"
  end
end
