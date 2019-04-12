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

  test "[validate_board_size_input] returns 3 or 4 if valid input" do
    assert GameSettings.validate_board_size_input(3) == {:ok, 3}
  end

  test "[validate_board_size_input] returns :error if input is not 3 or 4" do
    assert GameSettings.validate_board_size_input(5) ==
             {:error, :invalid_board_size_input}
  end

  test "[validate_board_size_input] returns :error if input is not a number" do
    assert GameSettings.validate_board_size_input("a") ==
             {:error, :invalid_board_size_input}
  end

  test "[validate_opponent_type_input] returns :ai if input is c" do
    assert GameSettings.validate_opponent_type_input("C") ==
             {:ok, :ai}
  end

  test "[validate_opponent_type_input] returns :opponent if input is l" do
    assert GameSettings.validate_opponent_type_input("L") ==
             {:ok, :opponent}
  end

  test "[validate_opponent_type_input] returns :error if input is not l or c" do
    assert GameSettings.validate_opponent_type_input("a") ==
             {:error, :invalid_opponent_type_input}
  end

  test "[handle_board_size_input] returns valid result if input is string 3" do
    assert GameSettings.handle_board_size_input("3") ==
             {:ok, 3}
  end

  test "[handle_board_size_input] returns :error if input is string 1" do
    assert GameSettings.handle_board_size_input("1") ==
             {:error, :invalid_board_size_input}
  end

  test "[handle_board_size_input] returns :error if input is string 2" do
    assert GameSettings.handle_board_size_input("2") ==
             {:error, :invalid_board_size_input}
  end

  test "[handle_opponent_type_input] returns :ok tuple if input is C of character type" do
    assert GameSettings.handle_opponent_type_input('C\n') == {:ok, :ai}
  end
end
