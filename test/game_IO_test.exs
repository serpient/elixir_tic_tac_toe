defmodule Game_Output_Test do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest GameIO

  test "[print_board] Prints 3x3 board to CL" do
    initial_board = %{
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

    assert capture_io(fn -> GameIO.print_board(initial_board) end) ==
             GameIO.get_board(initial_board) <> "\n"
  end

  test "[get_other_player_symbol] Toggles player symbols from X -> O" do
    assert GameIO.get_other_player_symbol("X") == "O"
  end

  test "[get_other_player_symbol] Toggles player symbols from O -> X" do
    assert GameIO.get_other_player_symbol("O") == "X"
  end

  test "[get_message] Gets correct message with key" do
    assert GameIO.get_message(:initial_player_prompt) == ~s(Select a numbered spot: )
  end

  test "[get_message] Gets default message on nil param" do
    assert GameIO.get_message(nil) == ~s(Select a numbered spot: )
  end

  test "[print_win] Prints win message" do
    initial_board = %{
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
    assert capture_io(fn -> GameIO.print_win(initial_board, "X") end) ==
             GameIO.get_board(initial_board) <> "\n"
             <>  "Player X - " <> GameIO.get_message(:wins_game) <> "\n"
  end

  test "[print_tie] Prints tie message" do
    initial_board = %{
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
    assert capture_io(fn -> GameIO.print_tie(initial_board) end) ==
             GameIO.get_board(initial_board) <> "\n"
             <> GameIO.get_message(:game_is_a_tie) <> "\n"
  end
end
