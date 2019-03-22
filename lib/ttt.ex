defmodule TTT do
  @moduledoc """
  Documentation for TTT.
  """

  @doc """
  Hello world.

  ## Examples

      iex> TTT.hello()
      :world

  """
  def hello do
    :world
  end

  def get_player_name() do
    IO.gets("What is your name? \n")
    |> IO.puts
  end
end
