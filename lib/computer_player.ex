defmodule ComputerPlayer do
  def get_move(board) do
    next_move = picks(board)

    GameIO.get_computer_message(:chooses_spot, next_move)
    |> IO.puts()

    {:ok, next_move}
  end

  def picks(state) do
    state
    |> BoardState.get_empty_values()
    |> Enum.random()
  end
end
