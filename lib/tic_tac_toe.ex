defmodule TicTacToe do
  def handle_error(error, initial_board, current_player, updated_board \\ %{}) do
    {_status, error_message} = error

    case error_message do
      :game_is_a_tie -> GameIO.print_tie(updated_board)
      _ -> play(initial_board, error_message, current_player)
    end
  end

  def handle_check_for_win_result(result, initial_board, current_player) do
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
        handle_error({status, message}, initial_board, current_player, updated_board)
    end
  end

  def game_start() do
    board_size =
      GameIO.get_input_for_game_settings(:game_board_settings)
      |> ProcessInput.transform_to_integer()
      |> ProcessInput.process_input()

    GameIO.clear_io()

    Board.generate_board_data(board_size, board_size)
    |> Board.new_struct(board_size, board_size)
    |> play(nil, "X")
  end

  def play(
        board \\ %Board{},
        prompt \\ :initial_player_prompt,
        current_player \\ "X"
      ) do
    GameIO.clear_io()
    GameIO.print_board(board)

    GameIO.get_player_input(current_player, prompt)
    |> ProcessInput.handle_input(board)
    |> Board.handle_board_update(board, current_player)
    |> CheckForWins.check_for_win(board, current_player)
    |> handle_check_for_win_result(board, current_player)
  end
end
