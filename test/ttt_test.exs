defmodule TTTTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest TTT

  test "prints out question for player input" do
    assert capture_io(fn -> TTT.get_player_name() end) == "What is your name? \neof\n"
  end

  test "prints 3x3 board to CL" do
    assert capture_io(fn -> TTT.print_board() end) == ~s"""
           1    |2    |3    \n     |     |     \n_____|_____|_____\n4    |5    |6    \n     |     |     \n_____|_____|_____\n7    |8    |9    \n     |     |     \n     |     |     \n
           """
  end
end
