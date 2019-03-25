defmodule GameOutput do
  def get_message(key) do
    game_text = %{
      initial_board:
        ~s(1    |2    |3    \n     |     |     \n_____|_____|_____\n4    |5    |6    \n     |     |     \n_____|_____|_____\n7    |8    |9    \n     |     |     \n     |     |     \n),
      initial_player_prompt: ~s(Player X - Select a numbered spot to start the game: ),
      duplicate_input: ~s(That spot is taken! Please choose another number: ),
      invalid_input: ~s(Please enter a number: )
    }

    game_text[key]
  end

  def get_board(board_data) do
    ~s(1    |2    |3    \n  #{Map.get(board_data, 1)}  |  #{Map.get(board_data, 2)}  |  #{
      Map.get(board_data, 3)
    }  \n_____|_____|_____\n4    |5    |6    \n  #{Map.get(board_data, 4)}  |  #{
      Map.get(board_data, 5)
    }  |  #{Map.get(board_data, 6)}  \n_____|_____|_____\n7    |8    |9    \n  #{
      Map.get(board_data, 7)
    }  |  #{Map.get(board_data, 8)}  |  #{Map.get(board_data, 9)}  \n     |     |     \n)
  end
end
