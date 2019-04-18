defmodule BoardSizeSettingsTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest BoardSizeSettings

  test "[handle_board_size] if valid, returns result" do
    assert BoardSizeSettings.handle_board_size({:ok, 3}) == 3
  end

  test "[validate_board_size_input] returns 3 or 4 if valid input" do
    assert BoardSizeSettings.validate_board_size_input(3) == {:ok, 3}
  end

  test "[validate_board_size_input] returns :error if input is not 3 or 4" do
    assert BoardSizeSettings.validate_board_size_input(5) ==
             {:error, :invalid_board_size_input}
  end

  test "[validate_board_size_input] returns :error if input is not a number" do
    assert BoardSizeSettings.validate_board_size_input("a") ==
             {:error, :invalid_board_size_input}
  end

  test "[handle_board_size_input] returns valid result if input is string 3" do
    assert BoardSizeSettings.handle_board_size_input("3") ==
             {:ok, 3}
  end

  test "[handle_board_size_input] returns :error if input is string 1" do
    assert BoardSizeSettings.handle_board_size_input("1") ==
             {:error, :invalid_board_size_input}
  end

  test "[handle_board_size_input] returns :error if input is string 2" do
    assert BoardSizeSettings.handle_board_size_input("2") ==
             {:error, :invalid_board_size_input}
  end
end
