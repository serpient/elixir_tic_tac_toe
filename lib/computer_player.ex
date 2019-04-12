defmodule ComputerPlayer do
  def picks(board_state) do
    board_state
    |> BoardState.get_empty_values()
    |> Enum.random()
  end
end
