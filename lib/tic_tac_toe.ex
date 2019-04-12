defmodule TicTacToe do
  def handle_error(error, initial_board, current_player, updated_board \\ %{}) do
    {_status, error_message} = error

    case error_message do
      :game_is_a_tie -> GameIO.print_tie(updated_board)
      _ -> play(initial_board, error_message, current_player)
    end
  end

  def handle_play(result, initial_board, current_player) do
    {status, message, updated_board} = result

    cond do
      message == :no_win ->
        play(
          updated_board,
          :initial_player_prompt,
          GameIO.get_other_player_symbol(current_player, BoardState.opponent(updated_board))
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
      |>  ProcessInput.validate_board_size_input()

    GameIO.clear_io()

    opponent_type =
      GameIO.get_input_for_game_settings(:opponent_type_setting)
      |> ProcessInput.validate_opponent_type_input()

    GameIO.clear_io()

    Board.generate_board_data(board_size)
    |> BoardState.new_state(board_size, opponent_type)
    |> play(:initial_player_prompt, :player)
  end

  def play(
        board \\ %BoardState{},
        prompt \\ :initial_player_prompt,
        current_player \\ :player
      ) do
    GameIO.clear_io()
    GameIO.print_board(board)

    case current_player do
      :ai -> computer_turn(board)
      _ -> human_turn(board, prompt, current_player)
    end
    |> Board.handle_board_update(board, current_player)
    |> CheckForWins.check_for_win(board)
    |> handle_play(board, current_player)
  end

  def human_turn(
      board \\ %BoardState{},
      prompt \\ :initial_player_prompt,
      current_player \\ :player
    ) do
    GameIO.get_player_input(current_player, prompt)
    |> ProcessInput.handle_input(board)
  end
  def computer_turn(board) do
    {:ok, ComputerPlayer.picks(board) }
  end
end
