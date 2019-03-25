defmodule TTT do
  def print_board(board_data) do
    GameOutput.get_board(board_data)
    |> IO.puts()
  end

  def get_other_player_symbol(player_symbol) when player_symbol == "X" do
    "O"
  end

  def get_other_player_symbol(player_symbol) when player_symbol == "O" do
    "X"
  end

  def get_player_input(message) do
    GameOutput.get_message(message)
    |> IO.gets()
  end

  def initial_board() do
    %{
      1 => " ",
      2 => " ",
      3 => " ",
      4 => " ",
      5 => " ",
      6 => " ",
      7 => " ",
      8 => " ",
      9 => " "
    }
  end

  def handle_play(returned_value, board, current_player) do
    {status, value} = returned_value
    if (status == :error) do
      play(board, value, current_player)
    else
      play(value, :initial_player_prompt, get_other_player_symbol(current_player))
    end
  end

  def play(board \\ initial_board(), prompt \\ :initial_player_prompt, current_player \\ "X") do
    print_board(board)
    get_player_input(prompt)
    |> ProcessInput.handle_input(board, current_player)
    |> handle_play(board, current_player)
  end
end
