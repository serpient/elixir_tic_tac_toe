defmodule BoardState do
  defstruct board_size: 3,
            board_data: %{
              1 => :empty,
              2 => :empty,
              3 => :empty,
              4 => :empty,
              5 => :empty,
              6 => :empty,
              7 => :empty,
              8 => :empty,
              9 => :empty
            },
            opponent_type: :local

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

  def opponent(state) do
    state.opponent_type
  end

  def all_positions(state) do
    state
    |> board()
    |> Map.values()
  end

  def get_string_values(state) do
    state
    |> board()
    |> Enum.map(fn {_key, value} -> GameIO.get_player_token(value) end)
  end

  def get_empty_values(state) do
    state
    |> board()
    |> Enum.flat_map(fn {key, value} ->
      case value == :empty do
        true -> [key]
        _ -> []
      end
    end)
  end

  def update_board(position_to_update, state, player_symbol) do
    state
    |> board()
    |> Map.replace!(position_to_update, player_symbol)
    |> new_state(size(state), opponent(state))
  end

  def new_board(range) do
    range
    |> Enum.reduce(%{}, fn num, acc -> Map.put(acc, num, :empty) end)
  end

  def new_state(new_board_data, new_board_size \\ 3, new_opponent_type \\ :local) do
    %BoardState{
      board_data: new_board_data,
      board_size: new_board_size,
      opponent_type: new_opponent_type
    }
  end
end
