defmodule OpponentTypeSettingsTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest OpponentTypeSettings

  test "[handle_opponent_type] if valid, returns result" do
    assert OpponentTypeSettings.handle_opponent_type({:ok, :ai}) == :ai
  end

  test "[validate_opponent_type_input] returns :ai if input is c" do
    assert OpponentTypeSettings.validate_opponent_type_input("C") ==
             {:ok, :ai}
  end

  test "[validate_opponent_type_input] returns :opponent if input is l" do
    assert OpponentTypeSettings.validate_opponent_type_input("L") ==
             {:ok, :opponent}
  end

  test "[validate_opponent_type_input] returns :error if input is not l or c" do
    assert OpponentTypeSettings.validate_opponent_type_input("a") ==
             {:error, :invalid_opponent_type_input}
  end

  test "[handle_opponent_type_input] returns :ok tuple if input is C of character type" do
    assert OpponentTypeSettings.handle_opponent_type_input('C\n') == {:ok, :ai}
  end
end
