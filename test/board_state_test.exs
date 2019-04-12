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

  test "[get_string_values] returns string values of atoms in board data" do
    new_3x3_board_state = BoardState.new_state(BoardState.new_board(1..3), 3)

    assert BoardState.get_string_values(new_3x3_board_state) == [
             " ",
             " ",
             " "
           ]
  end
end
