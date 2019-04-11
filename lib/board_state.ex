defmodule BoardState do
  defstruct board_size: 3,
            board_data: %{
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

  def max_spaces(state) do
    board_size = state.board_size
    board_size * board_size
  end

  def size(state) do
    state.board_size
  end

  def board(state) do
    state.board_data
  end

  def all_keys(state) do
    state
    |> board()
    |> Map.values()
  end

  def update_board(position_to_update, board_state, player_symbol) do
    board(board_state)
    |> Map.replace!(position_to_update, player_symbol)
    |> new_state(size(board_state))
  end

  def new_board(range) do
    range
    |> Enum.reduce(%{}, fn num, acc -> Map.put(acc, num, " ") end)
  end

  def new_state(new_board_data, new_board_size \\ 3) do
    state = %BoardState{}

    %BoardState{
      state
      | board_data: new_board_data,
        board_size: new_board_size
    }
  end
end
