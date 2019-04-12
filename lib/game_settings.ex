defmodule GameSettings do
  def get_board_size(error \\ nil) do
    GameIO.clear_io()

    GameIO.get_input_for_game_settings(:game_board_settings, error)
    |> ProcessInput.handle_board_size_input()
    |> GameSettings.handle_board_size()
  end

  def handle_board_size(result) do
    {status, message} = result

    case status do
      :ok -> message
      :error -> GameSettings.get_board_size(message)
    end
  end

  def get_opponent_type(error \\ nil) do
    GameIO.clear_io()

    GameIO.get_input_for_game_settings(:opponent_type_setting, error)
    |> ProcessInput.handle_opponent_type_input()
    |> GameSettings.handle_opponent_type()
  end

  def handle_opponent_type(result) do
    {status, message} = result

    case status do
      :ok -> message
      :error -> GameSettings.get_opponent_type(message)
    end
  end
end
