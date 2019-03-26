defmodule TTT do
  def handle_error(error, board, current_player) do
    {_status, error_message} = error

    cond do
      error_message == :board_is_filled -> GameOutput.get_message(error_message) |> IO.puts()
      true -> play(board, error_message, current_player)
    end
  end

  def handle_win_check_result(win_result, initial_board, current_player) do
    {status, win_result_code, updated_board} = win_result

    cond do
      status == :error ->
        handle_error({status, win_result_code}, initial_board, current_player)

      win_result_code == :no_win ->
        play(
          updated_board,
          :initial_player_prompt,
          GameOutput.get_other_player_symbol(current_player)
        )

      win_result_code == :wins_game ->
        GameOutput.print_win(updated_board, current_player)
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

    GameOutput.get_player_input(current_player, prompt)
    |> ProcessInput.handle_input(board, current_player)
    |> CheckForWins.analyze()
    |> handle_win_check_result(board, current_player)
  end
end
