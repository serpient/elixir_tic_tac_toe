defmodule TicTacToeTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest TicTacToe

  test "[handle_play] Tie result will end the game and output Tie message." do
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

    tie_board_state = %BoardState{
      board_data: tie_board
    }

    assert capture_io(fn ->
             TicTacToe.handle_play(
               {:error, :game_is_a_tie, tie_board_state},
               tie_board_state,
               "O"
             )
           end) ==
             capture_io(fn -> GameIO.print_tie(tie_board_state) end)
  end

  test "[handle_play] Winning result will end the game and output Win Game message" do
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

    winning_board_state = %BoardState{
      board_data: winning_board
    }

    assert capture_io(fn ->
             TicTacToe.handle_play(
               {:ok, :wins_game, winning_board_state},
               winning_board_state,
               "X"
             )
           end) ==
             capture_io(fn -> GameIO.print_win(winning_board_state, "X") end)
  end
end
