defmodule Tic_Tac_Toe_Test do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest TicTacToe
  doctest GameIO
  doctest ProcessInput

  test "[handle_check_for_win_result] Tie result will end the game and output Tie message." do
    tie_board = %{
      1 => "X",
      2 => "X",
      3 => "O",
      4 => "O",
      5 => "O",
      6 => "X",
      7 => "X",
      8 => "O",
      9 => "X"
    }

    tie_board_spec = %Board{
      board_data: tie_board
    }

    assert capture_io(fn ->
             TicTacToe.handle_check_for_win_result(
               {:error, :game_is_a_tie, tie_board_spec},
               tie_board_spec,
               "O"
             )
           end) ==
             capture_io(fn -> GameIO.print_tie(tie_board_spec) end)
  end

  test "[handle_check_for_win_result] Winning result will end the game and output Win Game message" do
    winning_board = %{
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

    winning_board_spec = %Board{
      board_data: winning_board
    }

    assert capture_io(fn ->
             TicTacToe.handle_check_for_win_result(
               {:ok, :wins_game, winning_board_spec},
               winning_board_spec,
               "X"
             )
           end) ==
             capture_io(fn -> GameIO.print_win(winning_board_spec, "X") end)
  end

  # test "[handle_game_start] Gets game settings, updates default board data, and starts game" do
  #   assert Board.game_start() == {:ok}
  # end
end
