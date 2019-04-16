defmodule BoardSizeSettings do
  def get_board_size(error \\ nil) do
    GameIO.clear_io()

    GameIO.get_input_for_game_settings(:game_board_settings, error)
    |> handle_board_size_input()
    |> handle_board_size()
  end

  def handle_board_size(result) do
    case result do
      {:ok, message} -> message
      {:error, message} -> get_board_size(message)
    end
  end

  def validate_board_size_input(result) do
    case result do
      3 -> {:ok, result}
      4 -> {:ok, result}
      _ -> {:error, :invalid_board_size_input}
    end
  end

  def handle_board_size_input(input) do
    input
    |> ProcessInput.transform_to_integer()
    |> validate_board_size_input()
  end
end
