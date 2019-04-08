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
    has_no_empty_spaces_board = %{
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

    assert Board.has_empty_spaces?(has_no_empty_spaces_board) == false
  end

  test "[has_empty_spaces] Returns True if board has more spaces to play." do
    has_empty_spaces_board = %{
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

    assert Board.has_empty_spaces?(has_empty_spaces_board) == true
  end

  test "[is_a_empty_space] Returns false if position has player symbol." do
    space_is_already_taken_board = %{
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

    assert Board.is_a_empty_space(1, space_is_already_taken_board) == false
  end

  test "[is_a_empty_space] Returns true if position has no player symbol." do
    space_is_not_taken_board = %{
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

    assert Board.is_a_empty_space(2, space_is_not_taken_board) == true
  end


  test "[convert_horizontal_to_row] Converts board correctly" do
    initial_board = %{
      1 => "1",
      2 => "2",
      3 => "3",
      4 => "4",
      5 => "5",
      6 => "6",
      7 => "7",
      8 => "8",
      9 => "9"
    }
    assert Board.convert_horizontal_to_row(initial_board) == [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]]
  end

  test "[convert_vertical_to_row] Converts board correctly" do
    initial_board = %{
      1 => "1",
      2 => "2",
      3 => "3",
      4 => "4",
      5 => "5",
      6 => "6",
      7 => "7",
      8 => "8",
      9 => "9"
    }
    assert Board.convert_vertical_to_row(initial_board) == [["1", "4", "7"], ["2", "5", "8"], ["3", "6", "9"]]
  end

  test "[convert_diagonal_to_row] Converts board correctly" do
    initial_board = %{
      1 => "1",
      2 => "2",
      3 => "3",
      4 => "4",
      5 => "5",
      6 => "6",
      7 => "7",
      8 => "8",
      9 => "9"
    }
    assert Board.convert_diagonal_to_row(initial_board) == [["1", "5", "9"], ["3", "5", "7"]]
  end

  test "[generate_board_data] Generates board data" do
    row = 4
    column = 4
    new_4x4_board = %{
      1 => " ",
      2 => " ",
      3 => " ",
      4 => " ",
      5 => " ",
      6 => " ",
      7 => " ",
      8 => " ",
      9 => " ",
      10 => " ",
      11 => " ",
      12 => " ",
      13 => " ",
      14 => " ",
      15 => " ",
      16 => " ",
    }
    assert Board.generate_board_data(row, column) == new_4x4_board
  end

  test "[generate_board_for_print] Generates 4x4 board data for printing" do
    row=4
    column=4

    new_4x4_board = %{
      1 => "1",
      2 => "2",
      3 => "3",
      4 => "4",
      5 => "5",
      6 => "6",
      7 => "7",
      8 => "8",
      9 => "9",
      10 => "10",
      11 => "11",
      12 => "12",
      13 => "13",
      14 => "14",
      15 => "15",
      16 => "16",
    }
    [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16] = Map.values(new_4x4_board)

    margin_top = "\n"
    row1 = "1    |2    |3    |4    \n  #{p1}  |  #{p2}  |  #{p3}  |  #{p4}  \n_____|_____|_____|_____\n"
    row2 = "5    |6    |7    |8    \n  #{p5}  |  #{p6}  |  #{p7}  |  #{p8}  \n_____|_____|_____|_____\n"
    row3 = "9    |10    |11    |12    \n  #{p9}  |  #{p10}  |  #{p11}  |  #{p12}  \n_____|_____|_____|_____\n"
    row4 = "13    |14    |15    |16    \n  #{p13}  |  #{p14}  |  #{p15}  |  #{p16}  \n     |     |     |     \n"
    margin_bottom = "\n\n\n"


    assert Board.generate_board_for_print(row, column, new_4x4_board) == ~s(#{margin_top <> row1 <> row2 <> row3 <> row4 <> margin_bottom})
  end
end
