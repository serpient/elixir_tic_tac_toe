defmodule GameIO do
  def get_message(key) do
    game_text = %{
      initial_player_prompt: ~s(Select a numbered spot: ),
      duplicate_input: ~s(That spot is taken! Please choose another number: ),
      invalid_input: ~s(Please enter a number: ),
      game_is_a_tie: ~s(No more positions to play! The game is a tie.),
      invalid_input_range: ~s{Please enter a number from 1 - 9: },
      wins_game: ~s(Wins! \n\n),
      nil: ~s(Select a numbered spot: )
    }

    game_text[key]
  end

  def print_board(board_data) do
    board_data
    |> Board.generate_board_for_print
    |> IO.puts()
  end

  def get_other_player_symbol(player_symbol) do
    case player_symbol do
      "X" -> "O"
      "O" -> "X"
    end
  end

  def print_win(board_data, current_player) do
    print_board(board_data)

    ("Player #{current_player} - " <> GameIO.get_message(:wins_game))
    |> IO.puts()
  end

  def get_player_input(player, message) do
    ("Player #{player} - " <> GameIO.get_message(message))
    |> IO.gets()
  end

  def print_tie(board_data) do
    print_board(board_data)
    GameIO.get_message(:game_is_a_tie)
    |> IO.puts()
  end
end
