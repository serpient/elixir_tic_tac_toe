defmodule Update_Board_Test do
  use ExUnit.Case
  doctest UpdateBoard

  test "[handle_board_update] On :ok, updates board data and returns ok + updated data tuple" do
    initial_board = %{
      1 => "X",
      2 => "X",
      3 => "X",
      4 => " ",
      5 => " ",
      6 => " ",
      7 => " ",
      8 => " ",
      9 => " "
    }

    updated_board = %{
      1 => "X",
      2 => "X",
      3 => "X",
      4 => "X",
      5 => " ",
      6 => " ",
      7 => " ",
      8 => " ",
      9 => " "
    }

    assert UpdateBoard.handle_board_update({:ok, 4}, initial_board, "X") ==
             {:ok, updated_board}
  end

  test "[handle_board_update] On :error, returns the error tuple" do
    initial_board = %{
      1 => "X",
      2 => "X",
      3 => "X",
      4 => " ",
      5 => " ",
      6 => " ",
      7 => " ",
      8 => " ",
      9 => " "
    }

    assert UpdateBoard.handle_board_update({:error, :invalid_input}, initial_board, "X") ==
             {:error, :invalid_input}
  end
end
