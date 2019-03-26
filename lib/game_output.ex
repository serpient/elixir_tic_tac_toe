defmodule GameOutput do
  def get_message(key) do
    game_text = %{
      initial_player_prompt: ~s(Select a numbered spot: ),
      duplicate_input: ~s(That spot is taken! Please choose another number: ),
      invalid_input: ~s(Please enter a number: ),
      board_is_filled: ~s(No more positions to play! The game is a tie.),
      invalid_input_range: ~s{Please enter a number from 1 - 9: },
      wins_game: ~s(Wins!),
      nil: ~s( - Select a numbered spot: ),
    }

    game_text[key]
  end

  def get_board(board_data) do
    [p1, p2, p3, p4, p5, p6, p7, p8, p9] = Map.values(board_data)

    margin_top = "\n"
    row1 = "1    |2    |3    \n  #{p1}  |  #{p2}  |  #{p3}  \n_____|_____|_____\n"
    row2 = "4    |5    |6    \n  #{p4}  |  #{p5}  |  #{p6}  \n_____|_____|_____\n"
    row3 = "7    |8    |9    \n  #{p7}  |  #{p8}  |  #{p9}  \n     |     |     \n"
    margin_bottom = "\n\n"

    ~s(#{margin_top <> row1 <> row2 <> row3 <> margin_bottom})
  end
end
