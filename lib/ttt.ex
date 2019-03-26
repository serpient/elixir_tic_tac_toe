defmodule TTT do
  def get_player_input(player, message) do
    ("Player #{player} - " <> GameOutput.get_message(message))
    |> IO.gets()
  end

  def check_for_empty_spaces(board) do
    Map.values(board)
    |> Enum.any?(fn value -> value == " " end)
  end

  def handle_win(updated_board, current_player) do
    GameOutput.print_board(updated_board)

    "Player #{current_player} - " <> GameOutput.get_message(:wins_game)
    |> IO.puts()
  end

  def handle_error(error, board, current_player) do
    {_status, error_message} = error

    cond do
      error_message == :board_is_filled -> GameOutput.get_message(error_message) |> IO.puts()
      true -> play(board, error_message, current_player)
    end
  end

  def handle_validation_result(input_validation_result, board, current_player) do
    {status, results} = input_validation_result

    cond do
      status == :error -> handle_error(input_validation_result, board, current_player)
      status == :ok -> CheckForWins.analyze(results)
    end
  end

  def handle_win_check_result(win_result, current_player) do
    {_win_result_status, win_result_code, updated_board} = win_result

    cond do
      win_result_code == :no_win ->
        play(updated_board, :initial_player_prompt, GameOutput.get_other_player_symbol(current_player))

      win_result_code == :wins_game ->
        handle_win(updated_board, current_player)
    end
  end

  def play(
        board \\ %{
          1 => " ",
          2 => " ",
          3 => " ",
          4 => " ",
          5 => " ",
          6 => " ",
          7 => " ",
          8 => " ",
          9 => " "
        },
        prompt \\ :initial_player_prompt,
        current_player \\ "X"
      ) do
    GameOutput.print_board(board)

    case check_for_empty_spaces(board) do
      false ->
        handle_error({:error, :board_is_filled}, nil, nil)

      true ->
          get_player_input(current_player, prompt)
          |> ProcessInput.handle_input(board, current_player)
          |> handle_validation_result(board, current_player)
          |> handle_win_check_result(current_player)
    end
  end
end
