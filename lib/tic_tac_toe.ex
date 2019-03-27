defmodule TicTacToe do
  def handle_error(error, board, current_player) do
    {_status, error_message} = error

    case error_message do
      :game_is_a_tie -> GameIO.get_message(error_message) |> IO.puts()
      _ -> play(board, error_message, current_player)
    end
  end

  def handle_win_check_result(result, initial_board, current_player) do
    {status, message, updated_board} = result

    cond do
      message == :no_win ->
        play(
          updated_board,
          :initial_player_prompt,
          GameIO.get_other_player_symbol(current_player)
        )

      message == :wins_game ->
        GameIO.print_win(updated_board, current_player)

      status == :error ->
        handle_error({status, message}, initial_board, current_player)
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
    GameIO.print_board(board)

    GameIO.get_player_input(current_player, prompt)
    |> ProcessInput.handle_input(board, current_player)
    |> UpdateBoard.handle_board_update(board, current_player)
    |> CheckForWins.handle_win_check(board, current_player)
    |> handle_win_check_result(board, current_player)
  end
end
