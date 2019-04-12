defmodule ComputerPlayer do
  def picks(board_state) do
    board_state
    |> BoardState.get_empty_values()
    |> Enum.random()
  end

  def get_move(board) do
    next_move = ComputerPlayer.picks(board)

    GameIO.get_computer_message(:chooses_spot, next_move)
    |> IO.puts()

    {:ok, next_move}
  end
end
