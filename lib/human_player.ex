defmodule HumanPlayer do
  def get_move(
        board \\ %BoardState{},
        prompt \\ :initial_player_prompt,
        current_player \\ :player
      ) do
    current_player
    |> GameIO.get_player_input(prompt)
    |> handle_input(board)
  end

  def handle_input(input, state) do
    input
    |> ProcessInput.transform_to_integer
    |> validate_input(state)
  end

  defp validate_input(result, state) when is_integer(result) do
    board = BoardState.board(state)
    max_spaces = BoardState.max_spaces(state)

    cond do
      Board.is_position_empty?(result, board) -> {:ok, result}
      result > max_spaces || result < 1 -> {:error, :invalid_input_range}
      true -> {:error, :duplicate_input}
    end
  end

  defp validate_input(error, _state) do
    error
  end
end
