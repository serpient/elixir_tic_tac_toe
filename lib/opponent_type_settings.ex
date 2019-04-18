defmodule OpponentTypeSettings do
  def get_opponent_type(error \\ nil) do
    GameIO.clear_io()

    GameIO.get_input_for_game_settings(:opponent_type_setting, error)
    |> handle_opponent_type_input()
    |> handle_opponent_type()
  end

  def handle_opponent_type_input(input) do
    input
    |> ProcessInput.transform_to_string()
    |> validate_opponent_type_input()
  end

  def validate_opponent_type_input(result) do
    case result do
      "C" -> {:ok, :ai}
      "L" -> {:ok, :opponent}
      _ -> {:error, :invalid_opponent_type_input}
    end
  end

  def handle_opponent_type(result) do
    case result do
      {:ok, message} -> message
      {:error, message} -> get_opponent_type(message)
    end
  end
end
