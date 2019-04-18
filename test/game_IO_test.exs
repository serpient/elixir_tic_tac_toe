defmodule GameIOTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest GameIO

  test "[get_other_player_symbol] Toggles player symbols from X -> O" do
    assert GameIO.get_other_player_symbol(:player, :local) == :opponent
  end

  test "[get_other_player_symbol] Toggles player symbols from O -> X" do
    assert GameIO.get_other_player_symbol(:opponent, :local) == :player
  end

  test "[get_message] Gets correct message with key" do
    assert GameIO.get_message(:initial_player_prompt) == ~s(Select a numbered spot: )
  end

  test "[get_message] Gets default message on no param" do
    assert GameIO.get_message() == ~s(Select a numbered spot: )
  end

  test "[print_win] Prints win message" do
    winning_board = %{
      1 => :empty,
      2 => :empty,
      3 => :empty,
      4 => :empty,
      5 => :empty,
      6 => :empty,
      7 => :empty,
      8 => :empty,
      9 => :empty
    }

    winning_board_state = %BoardState{
      board_data: winning_board
    }

    assert capture_io(fn -> GameIO.print_win(winning_board_state, "X") end) ==
             capture_io(fn -> GameIO.clear_io() end) <>
               PrintableBoard.generate_board_for_print(winning_board_state) <>
               "\n" <>
               "Player X - " <> GameIO.get_message(:wins_game) <> "\n"
  end

  test "[print_tie] Prints tie message" do
    tie_board = %{
      1 => :empty,
      2 => :empty,
      3 => :empty,
      4 => :empty,
      5 => :empty,
      6 => :empty,
      7 => :empty,
      8 => :empty,
      9 => :empty
    }

    tie_board_state = %BoardState{
      board_data: tie_board
    }

    assert capture_io(fn -> GameIO.print_tie(tie_board_state) end) ==
             capture_io(fn -> GameIO.clear_io() end) <>
               PrintableBoard.generate_board_for_print(tie_board_state) <>
               "\n" <>
               GameIO.get_message(:game_is_a_tie) <> "\n"
  end

  test "[get_input_for_game_settings] Will get player settings input at beginning of game" do
    assert capture_io(fn -> GameIO.get_input_for_game_settings(:game_board_settings, nil) end) ==
             GameIO.game_start_banner(:game_board_settings)
  end
end
