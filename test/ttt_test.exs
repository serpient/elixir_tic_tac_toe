defmodule TTTTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest TTT

  test "greets the world" do
    assert TTT.hello() == :world
  end

  test "prints out question for player input" do
    assert capture_io(fn -> TTT.get_player_name() end) == "What is your name? \neof\n"
  end
end
