defmodule ProcessInput do
  def update_board(position_to_update, board_data, player_symbol)
      when is_integer(position_to_update) do
    {:ok, Map.replace!(board_data, position_to_update, player_symbol)}
  end

  def update_board(error, _board_data, _player_symbol) do
    error
  end

  def transform_to_integer(string) do
    Integer.parse(string)
  end

  def process_input(string, _board, _current_player) when is_tuple(string) do
    Tuple.to_list(string)
    |> Enum.fetch!(0)
  end

  def process_input(_string, _board, _current_player) do
    {:error, :invalid_input}
  end

  def is_empty(board_position, board) do
    Map.get(board, board_position) == " "
  end

  def validate_input(result, board, _current_player) when is_integer(result) do
    cond do
      is_empty(result, board) == true -> result
      result > 9 || result < 1 -> {:error, :invalid_input_range}
      true -> {:error, :duplicate_input}
    end
  end

  def validate_input(error, _board, _current_player) do
    error
  end

  def handle_validation_result(input_validation_result, board, current_player) do
    {status, _results} = input_validation_result

    cond do
      status == :error -> TTT.handle_error(input_validation_result, board, current_player)
      true -> input_validation_result
    end
  end

  @spec handle_input(binary(), any(), any()) :: :ok | {any(), any()}
  def handle_input(input, board, current_player) do
    transform_to_integer(input)
    |> process_input(board, current_player)
    |> validate_input(board, current_player)
    |> update_board(board, current_player)
    |> handle_validation_result(board, current_player)
  end
end

# feels weird that im passing errors down through the entire chain
# before it is resolved.
# i want to break out of chain when I see error
