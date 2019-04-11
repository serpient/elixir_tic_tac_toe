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

    tie_board_spec = %BoardState{
      board_data: tie_board
    }

    assert capture_io(fn ->
             TicTacToe.handle_play(
               {:error, :game_is_a_tie, tie_board_spec},
               tie_board_spec,
               "O"
             )
           end) ==
             capture_io(fn -> GameIO.print_tie(tie_board_spec) end)
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

    winning_board_spec = %BoardState{
      board_data: winning_board
    }

    assert capture_io(fn ->
             TicTacToe.handle_play(
               {:ok, :wins_game, winning_board_spec},
               winning_board_spec,
               "X"
             )
           end) ==
             capture_io(fn -> GameIO.print_win(winning_board_spec, "X") end)
  end

  test "[computer_turn] Triggers computer player picks when player_type is :ai" do
    computer_board = %{
      1 => :empty,
      2 => :player,
      3 => :player,
    }

    computer_board_spec = BoardState.new_state(computer_board, 3, :ai)

    updated_computer_board = %{
      1 => :ai,
      2 => :player,
      3 => :player,
    }

    updated_computer_board_state = BoardState.new_state(updated_computer_board, 3, :ai)

    assert TicTacToe.computer_turn(computer_board_spec, :ai)
        == {:ok, updated_computer_board_state}
  end
end
