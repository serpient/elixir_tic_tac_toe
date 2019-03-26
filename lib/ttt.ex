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

  def get_player_input(player, message) do
    "Player #{player} - " <> GameOutput.get_message(message)
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

  def handle_play(win_result_code, returned_value, current_player) when win_result_code == :no_win do
    {_status, updated_board} = returned_value
    play(updated_board, nil, get_other_player_symbol(current_player))
  end

  def handle_play(win_result_code, returned_value, current_player) when win_result_code == :wins_game do
    {_status, updated_board} = returned_value

    print_board(updated_board)

    "Player " <> current_player <> GameOutput.get_message(:wins_game)
    |> IO.puts()
  end

  def handle_error(error, board, current_player) do
    {_status, error_message} = error

    cond do
      error_message == :board_is_filled -> GameOutput.get_message(error_message) |> IO.puts()
      true -> play(board, error_message, current_player)
    end
  end

  def play(board \\ initial_board(), prompt \\ :initial_player_prompt, current_player \\ "X") do
    print_board(board)

    case check_for_empty_spaces(board) do
      false ->
        handle_error({:error, :board_is_filled}, nil, nil)

      true ->
        input_validation_result = get_player_input(current_player, prompt) |> ProcessInput.handle_input(board, current_player)

        {status, _result} = input_validation_result
        win_result = cond do
          status == :error -> input_validation_result
          status == :ok -> CheckForWins.analyze(board)
        end

        {win_result_status, win_result_code} = win_result
        cond do
          win_result_code == :no_win -> handle_play(win_result_code, input_validation_result, current_player)
          win_result_code == :wins_game -> handle_play(win_result_code, input_validation_result, current_player)
          win_result_status == :error -> handle_error(input_validation_result, board, current_player)
        end

    end
  end
end
