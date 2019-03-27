defmodule Game_Output_Test do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest GameIO

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

    assert capture_io(fn -> GameIO.print_board(initial_board) end) ==
             GameIO.get_board(initial_board) <> "\n"
  end

  test "Toggles player symbols. From X -> O" do
    assert GameIO.get_other_player_symbol("X") == "O"
  end

  test "Toggles player symbols. From O -> X" do
    assert GameIO.get_other_player_symbol("O") == "X"
  end

  test "Gets correct message." do
    assert GameIO.get_message(:initial_player_prompt) == ~s(Select a numbered spot: )
  end

  test "Gets default message on nil param" do
    assert GameIO.get_message(nil) == ~s(Select a numbered spot: )
  end
end
