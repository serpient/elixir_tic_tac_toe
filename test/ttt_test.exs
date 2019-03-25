defmodule TTTTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest TTT
  doctest GameOutput

  test "prints out question for player input" do
    assert capture_io(fn -> TTT.get_player_name() end) == "What is your name? \neof\n"
  end

  test "prints 3x3 board to CL" do
    initial_board = %{
      1 => "",
      2 => "",
      3 => "",
      4 => "",
      5 => "",
      6 => "",
      7 => "",
      8 => "",
      9 => "",
    }
    assert capture_io(fn -> TTT.print_board(initial_board) end) == GameOutput.get_message(:initial_board) <> "\n"
  end

  test "CL outputs starter text for game" do
    assert capture_io(fn -> TTT.play() end) == GameOutput.get_message(:initial_board) <> "\n" <> GameOutput.get_message(:initial_player_prompt)
  end

  test "After Player X input, board is correctly displayed with new input" do
    initial_board = %{
      1 => "",
      2 => "",
      3 => "",
      4 => "",
      5 => "",
      6 => "",
      7 => "",
      8 => "",
      9 => "",
    }
    updated_board = %{
      1 => "X",
      2 => "",
      3 => "",
      4 => "",
      5 => "",
      6 => "",
      7 => "",
      8 => "",
      9 => "",
    }
    assert capture_io(fn -> TTT.update_board(1, "X", initial_board) end) == GameOutput.get_board(updated_board)
  end
end
