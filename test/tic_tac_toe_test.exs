defmodule Tic_Tac_Toe_Test do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest TicTacToe
  doctest GameIO
  doctest ProcessInput

  test "[handle_win_check_result] Tie result will end the game and output Tie message." do
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

    assert capture_io(fn ->
             TicTacToe.handle_win_check_result(
               {:error, :game_is_a_tie, initial_board},
               initial_board,
               "O"
             )
           end) ==
             GameIO.get_board(initial_board) <> "\n" <>
             GameIO.get_message(:game_is_a_tie) <> "\n"
  end

  test "[handle_win_check_result] Winning result will end the game and output Win Game message" do
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
             GameIO.get_board(initial_board) <>
               "\n" <>
               "Player X - " <> GameIO.get_message(:wins_game) <> "\n"
  end

  # test "No win continues the game" do
  #   initial_board = %{
  #     1 => "X",
  #     2 => "O",
  #     3 => "X",
  #     4 => " ",
  #     5 => " ",
  #     6 => " ",
  #     7 => " ",
  #     8 => " ",
  #     9 => " "
  #   }

  #   updated_board = %{
  #     1 => "X",
  #     2 => "O",
  #     3 => "X",
  #     4 => "O",
  #     5 => " ",
  #     6 => " ",
  #     7 => " ",
  #     8 => " ",
  #     9 => " "
  #   }

  #   assert TicTacToe.handle_win_check_result(
  #            {:error, :no_win, updated_board},
  #            initial_board,
  #            "X"
  #          ) !== {:error}
  # end
end
