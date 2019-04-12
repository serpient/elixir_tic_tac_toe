defmodule Game_Settings_Test do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "[handle_board_size] if valid, returns result" do
    assert GameSettings.handle_board_size({:ok, 3}) == 3
  end

  # test "[handle_board_size] if invalid, prompts for input again" do
  #   assert capture_io(fn -> GameSettings.handle_board_size({:error, :invalid_board_size_input}) end)
  #     == capture_io(fn -> GameSettings.set_board_size() end)
  # end

  test "[handle_opponent_type] if valid, returns result" do
    assert GameSettings.handle_opponent_type({:ok, :ai}) == :ai
  end
end
