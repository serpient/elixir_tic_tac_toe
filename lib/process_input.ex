defmodule ProcessInput do
  def transform_to_integer(string) do
    parse_result = Integer.parse(string)
    case parse_result do
      :error -> {:error, :invalid_input}
      _ -> {integer, _remainder} = parse_result; integer
    end
  end

  def transform_to_string(input) do
    input
    |> to_string()
    |> String.trim()
  end
end
