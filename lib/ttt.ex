defmodule TTT do
  def get_player_name() do
    IO.gets("What is your name? \n")
    |> IO.puts()
  end

  def print_board() do
    IO.puts(GameText.get(:initial_board))
  end

  def play() do
    print_board()
    IO.gets(GameText.get(:initial_player_prompt))
  end
end
