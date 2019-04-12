defmodule TicTacToe do
  def handle_error(error, initial_board, current_player, updated_board \\ %{}) do
    {_status, error_message} = error

    case error_message do
      :game_is_a_tie -> GameIO.print_tie(updated_board)
      _ -> play(initial_board, error_message, current_player, nil)
    end
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

  def game_start() do
    board_size = GameSettings.get_board_size()
    opponent_type = GameSettings.get_opponent_type()

    GameIO.clear_io()

    Board.generate_board_data(board_size)
    |> BoardState.new_state(board_size, opponent_type)
    |> play(:initial_player_prompt, :player, opponent_type)
  end

  def play(
        board \\ %BoardState{},
        prompt \\ :initial_player_prompt,
        current_player \\ :player,
        opponent_type \\ :opponent
      ) do
    if opponent_type == :opponent or current_player == :ai or opponent_type == nil, do: GameIO.clear_io()
    GameIO.print_board(board)

    case current_player do
      :ai -> get_computer_move(board)
      _ -> get_human_move(board, prompt, current_player)
    end
    |> Board.handle_board_update(board, current_player)
    |> CheckForWins.check_for_win(board)
    |> handle_play(board, current_player)
  end

  def get_human_move(
        board \\ %BoardState{},
        prompt \\ :initial_player_prompt,
        current_player \\ :player
      ) do
    GameIO.get_player_input(current_player, prompt)
    |> ProcessInput.handle_input(board)
  end

  def get_computer_move(board) do
    GameIO.clear_io()
    next_move = ComputerPlayer.picks(board)
    IO.puts("\n\nComputer chooses spot #{next_move}.\n\n\n")

    {:ok, next_move}
  end
end
