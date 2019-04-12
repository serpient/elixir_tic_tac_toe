defmodule HumanPlayer do
  def get_move(
        board \\ %BoardState{},
        prompt \\ :initial_player_prompt,
        current_player \\ :player
      ) do
    GameIO.get_player_input(current_player, prompt)
    |> ProcessInput.handle_input(board)
  end
end
