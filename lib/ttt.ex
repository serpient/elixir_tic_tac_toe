defmodule TTT do
  def get_player_name() do
    IO.gets("What is your name? \n")
    |> IO.puts()
  end

  def print_board(board_data) do
    GameOutput.get_board(board_data)
    |> IO.puts
  end

  def update_board(position_to_update, player_symbol, board_data) do
    put_in board_data[position_to_update], player_symbol
    |> print_board
  end

  def play() do
    initial_board = %{
      1 => "",
      2 => "",
      3 => "",
      4 => "",
      5 => "",
      6 => "",
      7 => "",
      8 => "",
      9 => "",
    }
    print_board(initial_board)
    GameOutput.get_message(:initial_player_prompt)
    |> IO.gets
    |> update_board("X", initial_board)
  end
end
