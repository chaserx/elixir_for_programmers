defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view
  import GallowsWeb.GameStateHelper

  def game_over?(state) do
    state in [:lost || :won]
  end

  def new_game_button(conn) do
    button("New Game", to: Routes.hangman_path(conn, :create_game))
  end

  def turn(left, target) when target >= left do
    "opacity: 1"
  end

  def turn(left, target) do
    "opacity: 0.1"
  end
end
