defmodule GallowsWeb.HangmanHelper do
  def format_word(letters) do
    letters
    |> Enum.join(" ")
  end
end
