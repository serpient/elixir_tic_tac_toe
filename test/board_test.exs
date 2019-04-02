defmodule Board_Test do
  use ExUnit.Case
  doctest Board

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

    assert Board.handle_board_update({:ok, 4}, initial_board, "X") ==
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

    assert Board.handle_board_update({:error, :invalid_input}, initial_board, "X") ==
             {:error, :invalid_input}
  end

  test "[has_empty_spaces] Returns False if board is filled." do
    initial_board = %{
      1 => "X",
      2 => "O",
      3 => "X",
      4 => "O",
      5 => "X",
      6 => "O",
      7 => "X",
      8 => "O",
      9 => "X"
    }

    assert Board.has_empty_spaces?(initial_board) == false
  end

  test "[has_empty_spaces] Returns True if board has more spaces to play." do
    initial_board = %{
      1 => "X",
      2 => "O",
      3 => "X",
      4 => "O",
      5 => "X",
      6 => "O",
      7 => "X",
      8 => "O",
      9 => " "
    }

    assert Board.has_empty_spaces?(initial_board) == true
  end

  test "[is_a_empty_space] Returns false if position has player symbol." do
    initial_board = %{
      1 => "X",
      2 => " ",
      3 => " ",
      4 => " ",
      5 => " ",
      6 => " ",
      7 => " ",
      8 => " ",
      9 => " "
    }

    assert Board.is_a_empty_space(1, initial_board) == false
  end

  test "[is_a_empty_space] Returns true if position has no player symbol." do
    initial_board = %{
      1 => "X",
      2 => " ",
      3 => " ",
      4 => " ",
      5 => " ",
      6 => " ",
      7 => " ",
      8 => " ",
      9 => " "
    }

    assert Board.is_a_empty_space(2, initial_board) == true
  end

end
