defmodule GameText do
  def get(key) do
    game_text = %{
      initial_board: ~s(1    |2    |3    \n     |     |     \n_____|_____|_____\n4    |5    |6    \n     |     |     \n_____|_____|_____\n7    |8    |9    \n     |     |     \n     |     |     \n),
      initial_player_prompt: ~s(Player X - Select a numbered spot to start the game!\n),
    }
    game_text[key]
  end
end
