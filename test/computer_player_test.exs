defmodule Computer_Player_Test do
  use ExUnit.Case
  doctest ComputerPlayer

  test "[picks] Computer Player picks an empty space" do
    board = %{
      1 => :empty,
      2 => :player,
      3 => :opponent
    }

    new_board_state = BoardState.new_state(board, 3)
    assert ComputerPlayer.picks(new_board_state) == 1
  end

  test "[picks] Computer Player picks an empty space - v2" do
    board = %{
      1 => :player,
      2 => :empty,
      3 => :empty
    }

    new_board_state = BoardState.new_state(board, 3)
    assert ComputerPlayer.picks(new_board_state) != 1
  end
end
