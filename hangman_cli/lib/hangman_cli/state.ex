defmodule HangmanCli.State do
  # our state
  defstruct(game_service: nil, tally: nil, guess: "")
end
