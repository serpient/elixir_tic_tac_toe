defmodule Tic_Tac_Toe_Test do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest TicTacToe
  doctest GameOutput
  doctest ProcessInput

  test "Tie doesn't allow more input and outputs message." do
    initial_board = %{
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

    assert capture_io(fn -> TicTacToe.handle_win_check_result({:error, :board_is_filled, initial_board}, initial_board, "O") end) ==
               GameOutput.get_message(:board_is_filled) <> "\n"
  end

  test "Wins_results chains to win game message" do
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

    assert capture_io(fn ->
             TicTacToe.handle_win_check_result(
               {:ok, :wins_game, initial_board},
               initial_board,
               "X"
             )
           end) ==
             GameOutput.get_board(initial_board) <>
               "\n" <>
               "Player X - " <> GameOutput.get_message(:wins_game) <> "\n"
  end
end
