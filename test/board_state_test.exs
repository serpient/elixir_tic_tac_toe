defmodule Board_State_Test do
  use ExUnit.Case
  doctest BoardState

  test "[new_state] returns new struct with updated params" do
    new_4x4_board_data = Board.generate_board_data(4)

    assert BoardState.new_state(new_4x4_board_data, 4) ==
             %BoardState{
               board_data: new_4x4_board_data,
               board_size: 4
             }
  end
end
