defmodule TTT do
  def get_player_name() do
    IO.gets("What is your name? \n")
    |> IO.puts
  end
end
