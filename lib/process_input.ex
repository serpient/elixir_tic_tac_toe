defmodule ProcessInput do
  defp transform_to_integer(string) do
    Integer.parse(string)
  end

  defp process_input(string, _board, _current_player) when is_tuple(string) do
    string
    |> Tuple.to_list()
    |> Enum.fetch!(0)
  end

  defp process_input(_string, _board, _current_player) do
    {:error, :invalid_input}
  end

  defp validate_input(result, board, _current_player) when is_integer(result) do
    cond do
      Board.is_a_empty_space(result, board) == true -> {:ok, result}
      result > 9 || result < 1 -> {:error, :invalid_input_range}
      true -> {:error, :duplicate_input}
    end
  end

  defp validate_input(error, _board, _current_player) do
    error
  end

  def handle_input(input, board, current_player) do
    input
    |> transform_to_integer
    |> process_input(board, current_player)
    |> validate_input(board, current_player)
  end
end
