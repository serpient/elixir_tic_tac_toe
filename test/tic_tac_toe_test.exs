defmodule Tic_Tac_Toe_Test do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest TicTacToe
  doctest GameIO
  doctest ProcessInput

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

  test "[get_computer_move] Chooses random empty space and updates board" do
    computer_board = %{
      1 => :empty,
      2 => :player,
      3 => :player
    }

    computer_board_state = BoardState.new_state(computer_board, 3, :ai)

    assert TicTacToe.get_computer_move(computer_board_state)
        == {:ok, 1}
  end
end
