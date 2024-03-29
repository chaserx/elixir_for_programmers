defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns a structure" do

    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
    assert game.letters |> Enum.all?(fn letter -> String.match?("#{letter}", ~r/[a-zA-z]/) end)
  end


  test "state isn't changed for :won game" do
    game = Game.new_game()
           |> Map.put(:game_state, :won)
    assert { game, _tally } = Game.make_move(game, "x")
  end

  test "state isn't changed for :lost game" do
    game = Game.new_game()
           |> Map.put(:game_state, :lost)
    assert { game, _tally } = Game.make_move(game, "x")
  end

  test "first occurange of letter is not already used" do
    game = Game.new_game()
    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state != :already_used
    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    { game, _tally } = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  # test "a guessed word is a won game" do
  #   game = Game.new_game("wibble")
  #   game = Game.make_move(game, "w")
  #   assert game.game_state == :good_guess
  #   assert game.turns_left == 7
  #   game = Game.make_move(game, "i")
  #   assert game.game_state == :good_guess
  #   assert game.turns_left == 7
  #   game = Game.make_move(game, "b")
  #   assert game.game_state == :good_guess
  #   assert game.turns_left == 7
  #   game = Game.make_move(game, "l")
  #   assert game.game_state == :good_guess
  #   assert game.turns_left == 7
  #   game = Game.make_move(game, "e")
  #   assert game.game_state == :won
  #   assert game.turns_left == 7
  # end

  test "bad guess is recognized" do
    game = Game.new_game("wibble")
    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  # test "with last bad guess moved into lost game state" do
  #   game = Game.new_game("w")
  #   game = Game.make_move(game, "a")
  #   assert game.game_state == :bad_guess
  #   assert game.turns_left == 6
  #   game = Game.make_move(game, "b")
  #   assert game.game_state == :bad_guess
  #   assert game.turns_left == 5
  #   game = Game.make_move(game, "c")
  #   assert game.game_state == :bad_guess
  #   assert game.turns_left == 4
  #   game = Game.make_move(game, "d")
  #   assert game.game_state == :bad_guess
  #   assert game.turns_left == 3
  #   game = Game.make_move(game, "e")
  #   assert game.game_state == :bad_guess
  #   assert game.turns_left == 2
  #   game = Game.make_move(game, "f")
  #   assert game.game_state == :bad_guess
  #   assert game.turns_left == 1
  #   game = Game.make_move(game, "g")
  #   assert game.game_state == :lost
  # end

  test "with last bad guess moved into lost game state" do
    moves = [
      {"a", :bad_guess, 6},
      {"b", :bad_guess, 5},
      {"c", :bad_guess, 4},
      {"d", :bad_guess, 3},
      {"e", :bad_guess, 2},
      {"f", :bad_guess, 1},
      {"g", :lost, 1}
    ]

    game = Game.new_game("w")

    Enum.reduce(
      moves,
      game,
      fn({guess, state, turns_left}, game) ->
        { game, _tally } = Game.make_move(game, guess)
        assert game.game_state == state
        assert game.turns_left == turns_left
        game
      end
    )
  end

  test "a guessed word is a won game" do
    moves = [
      {"w", :good_guess, 7},
      {"i", :good_guess, 7},
      {"b", :good_guess, 7},
      {"l", :good_guess, 7},
      {"e", :won, 7}
    ]

    game = Game.new_game("wibble")

    Enum.reduce(
      moves,
      game,
      fn({guess, state, turns_left}, game) ->
        { game, _tally } = Game.make_move(game, guess)
        assert game.game_state == state
        assert game.turns_left == turns_left
        game
      end
    )
  end
end


