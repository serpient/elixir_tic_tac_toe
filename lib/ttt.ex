defmodule TTT do
  def get_player_name() do
    IO.gets("What is your name? \n")
    |> IO.puts()
  end

  def print_board() do
    IO.puts(
      ~s(1    |2    |3    \n     |     |     \n_____|_____|_____\n4    |5    |6    \n     |     |     \n_____|_____|_____\n7    |8    |9    \n     |     |     \n     |     |     \n)
    )
  end

  def play() do
    print_board()
    IO.gets(
      ~s(Player X - Select a numbered spot to start the game!\n)
    )
  end
end
