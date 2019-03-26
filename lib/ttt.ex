defmodule TTT do
  def print_board(board_data) do
    GameOutput.get_board(board_data)
    |> IO.puts()
  end

  def get_other_player_symbol(player_symbol) do
    cond do
      player_symbol == "X" -> "O"
      player_symbol == "O" -> "X"
    end
  end

  def get_player_input(message) do
    GameOutput.get_message(message)
    |> IO.gets()
  end

  def initial_board() do
    %{
      1 => " ",
      2 => " ",
      3 => " ",
      4 => " ",
      5 => " ",
      6 => " ",
      7 => " ",
      8 => " ",
      9 => " "
    }
  end

  def check_for_empty_spaces(board) do
    Map.values(board)
    |> Enum.any?(fn value -> value == " " end)
  end

  def handle_play(returned_value, board, current_player) do
    {status, updated_board} = returned_value

    cond do
      status == :error ->
        handle_error(returned_value, board, current_player)

      status == :ok ->
        play(updated_board, :initial_player_prompt, get_other_player_symbol(current_player))
    end
  end

  def handle_error(error, board, current_player) do
    {_status, error_message} = error

    cond do
      error_message == :board_is_filled -> GameOutput.get_message(error_message) |> IO.puts()
      true -> play(board, error_message, current_player)
    end
  end

  def play(board \\ initial_board(), prompt \\ :initial_player_prompt, current_player \\ "X") do
    case check_for_empty_spaces(board) do
      false ->
        handle_error({:error, :board_is_filled}, nil, nil)

      true ->
        print_board(board)

        get_player_input(prompt)
        |> ProcessInput.handle_input(board, current_player)
        |> handle_play(board, current_player)
    end
  end
end
