defmodule String_Board_Test do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest StringBoard

  test "[generate_board_for_print] Generates 4x4 board data for printing" do
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
      16 => "16"
    }

    four_board_spec = %BoardState{
      board_data: new_4x4_board,
      board_size: 4,
    }

    [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16] =
      Map.values(new_4x4_board)

    margin_top = "\n"

    row1 =
      "1    |2    |3    |4    \n  #{p1}  |  #{p2}  |  #{p3}  |  #{p4}  \n_____|_____|_____|_____\n"

    row2 =
      "5    |6    |7    |8    \n  #{p5}  |  #{p6}  |  #{p7}  |  #{p8}  \n_____|_____|_____|_____\n"

    row3 =
      "9    |10   |11   |12   \n  #{p9}  |  #{p10}  |  #{p11}  |  #{p12}  \n_____|_____|_____|_____\n"

    row4 =
      "13   |14   |15   |16   \n  #{p13}  |  #{p14}  |  #{p15}  |  #{p16}  \n     |     |     |     \n"

    margin_bottom = "\n\n\n"

    assert StringBoard.generate_board_for_print(four_board_spec) ==
             ~s(#{margin_top <> row1 <> row2 <> row3 <> row4 <> margin_bottom})
  end

  test "[generate_board_for_print] Generates 3x3 board data for printing" do
    new_3x3_board = %{
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

    three_board_spec = %BoardState{
      board_data: new_3x3_board,
      board_size: 3,
    }

    [p1, p2, p3, p4, p5, p6, p7, p8, p9] = Map.values(new_3x3_board)

    margin_top = "\n"

    row1 = "1    |2    |3    \n  #{p1}  |  #{p2}  |  #{p3}  \n_____|_____|_____\n"
    row2 = "4    |5    |6    \n  #{p4}  |  #{p5}  |  #{p6}  \n_____|_____|_____\n"
    row3 = "7    |8    |9    \n  #{p7}  |  #{p8}  |  #{p9}  \n     |     |     \n"

    margin_bottom = "\n\n\n"

    assert StringBoard.generate_board_for_print(three_board_spec) ==
             ~s(#{margin_top <> row1 <> row2 <> row3 <> margin_bottom})
  end

  test "[print_board] Prints 3x3 board to CL" do
    initial_3x3_board = %{
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

    three_board_spec = %BoardState{
      board_data: initial_3x3_board
    }

    assert capture_io(fn -> GameIO.print_board(three_board_spec) end) ==
             StringBoard.generate_board_for_print(three_board_spec) <> "\n"
  end
end
