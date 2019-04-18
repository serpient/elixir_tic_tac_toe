# TTT - Build a tic tac toe game in the command line. 

### Rule 1: Follow TDD
### Rule 2: Single Responsibility Principle
### Rule 3: Elixir / Functional Programming Best Practices

## Phase 1: 2 Local Players
- Simple instructions for the user should be provided
- Standard 3 X 3 board
- "X" and "O" markers
- Winner or tie games should be identified and game should end
- Human vs Human (local)

*Test plan:*
1. Outputs a standard 3x3 board to command line 
2. Accepts player input
3. Checks for win
5. If win: Outputs win message with player
If no win -- continue
6. Updates board with current player marker
7. Toggle current player

## Phase 2: Simple Computer Player
- Ability to play against a computer player. The computer should just choose random moves. 
- Ability to choose between a 3x3 and 4x4 board.

![gif](https://media.giphy.com/media/MC8smtRsz4ajjbqTG1/giphy.gif)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `elixir_tic_tac_toe` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:elixir_tic_tac_toe, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/elixir_tic_tac_toe](https://hexdocs.pm/elixir_tic_tac_toe).

## Game Entry
`TicTacToe.game_start()`

## Compile project
`mix compile`

## After compilation, start a iex session
`iex -S mix`

## Running Tests
`mix test`

## Automatic code formatting
`mix format`
