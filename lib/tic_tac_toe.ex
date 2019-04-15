defmodule TicTacToe do
  def game_start() do
    board_size = GameSettings.get_board_size()
    opponent_type = GameSettings.get_opponent_type()

    GameIO.clear_io()

    board_size
    |> Board.generate_board_data
    |> BoardState.new_state(board_size, opponent_type)
    |> play(:initial_player_prompt, :player, opponent_type)
  end

  defp play(
        board,
        prompt,
        current_player,
        opponent_type
      ) do
    GameIO.clear_console_logic(current_player, opponent_type)
    case current_player do
      :ai -> ComputerPlayer.get_move(board)
      _ ->  GameIO.print_board(board); HumanPlayer.get_move(board, prompt, current_player)
    end
    |> Board.handle_board_update(board, current_player)
    |> CheckForWins.check_for_win(board)
    |> handle_play(board, current_player)
  end


  def handle_play(result, initial_board, current_player) do
    {status, message, updated_board} = result

    cond do
      message == :no_win ->
        play(
          updated_board,
          :initial_player_prompt,
          GameIO.get_other_player_symbol(current_player, BoardState.opponent(updated_board)),
          BoardState.opponent(updated_board)
        )

      message == :wins_game ->
        GameIO.print_win(updated_board, current_player)

      status == :error ->
        handle_error({status, message}, initial_board, current_player, updated_board)
    end
  end

  def handle_error(error, initial_board, current_player, updated_board \\ %{}) do
    {_status, error_message} = error

    case error_message do
      :game_is_a_tie -> GameIO.print_tie(updated_board)
      _ -> play(initial_board, error_message, current_player, nil)
    end
  end
end
