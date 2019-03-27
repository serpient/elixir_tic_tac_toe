defmodule UpdateBoard do
  def handle_board_update(result, board_data, player_symbol) do
    {status, position_to_update} = result
    case status do
      :ok ->  {:ok, Map.replace!(board_data, position_to_update, player_symbol)}
      :error -> result
    end
  end
end
