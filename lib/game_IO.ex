defmodule GameIO do
  def get_message(key) do
    game_text = %{
      initial_player_prompt: ~s(Select a numbered spot: ),
      duplicate_input: ~s(That spot is taken! Please choose another number: ),
      invalid_input: ~s(Please enter a number: ),
      game_is_a_tie: ~s(No more positions to play! The game is a tie.),
      invalid_input_range: ~s{Please enter a valid number: },
      wins_game: ~s(Wins! \n\n),
      nil: ~s(Select a numbered spot: ),
      game_board_settings: ~s(     Please select a board size -- 3 or 4: ),
      opponent_type_setting: "Select your opponent -- (L)ocal or (C)omputer:"
    }

    game_text[key]
  end

  def print_computer_message(key, value) do
    computer_player_message = %{
      chooses_spot: ~s(\n\nComputer chooses spot #{value}.\n\n\n)
    }

    computer_player_message[key]
  end

  def print_board(board_state) do
    board_state
    |> PrintableBoard.generate_board_for_print()
    |> IO.puts()
  end

  def get_other_player_symbol(player_symbol, opponent_type) do
    opponent = if opponent_type == :ai, do: :ai, else: :opponent

    case player_symbol do
      :player -> opponent
      _ -> :player
    end
  end

  def get_player_token(player_symbol) do
    case player_symbol do
      :empty -> " "
      :player -> "X"
      :opponent -> "O"
      :ai -> "O"
      _ -> player_symbol
    end
  end

  def print_win(board_state, current_player) do
    clear_io()
    print_board(board_state)

    ("Player #{get_player_token(current_player)} - " <> GameIO.get_message(:wins_game))
    |> IO.puts()
  end

  def get_player_input(player, message) do
    ("Player #{get_player_token(player)} - " <> GameIO.get_message(message))
    |> IO.gets()
  end

  def print_tie(board_state) do
    clear_io()
    print_board(board_state)

    GameIO.get_message(:game_is_a_tie)
    |> IO.puts()
  end

  def game_start_banner(message) do
    empty_row = ~s(                                                            \n\n)
    border_row = ~s(#######################################################     \n)

    "\n" <>
      border_row <>
      String.duplicate(empty_row, 2) <>
      ~s(               T I C . T A C . T O E                         \n\n) <>
      ~s(  #{GameIO.get_message(message)}             \n) <>
      String.duplicate(empty_row, 2) <>
      border_row <>
      "\n"
  end

  def get_input_for_game_settings(message, error) do
    GameIO.game_start_banner(message)
    |> IO.gets()
  end

  def clear_io() do
    IO.write("\e[H\e[J")
    IEx.dont_display_result()
  end

  def clear_console_logic(current_player, opponent_type) do
    if opponent_type == :opponent or
      current_player == :ai or
      opponent_type == nil,
    do: GameIO.clear_io()
  end
end
