defmodule TTTTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest TTT
  doctest GameText

  test "prints out question for player input" do
    assert capture_io(fn -> TTT.get_player_name() end) == "What is your name? \neof\n"
  end

  test "prints 3x3 board to CL" do
    assert capture_io(fn -> TTT.print_board() end) == GameText.get(:initial_board) <> "\n"
  end

  test "CL outputs starter text for game" do
    assert capture_io(fn -> TTT.play() end) == GameText.get(:initial_board) <> "\n" <> GameText.get(:initial_player_prompt)
  end
end
