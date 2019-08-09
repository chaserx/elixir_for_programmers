defmodule Dictionary.WordList do
  # NOTE(chaserx): __MODULE__ is a shortcut to the name of this file
  # the @me is a module attribute kinda like a flexible constant
  @me __MODULE__

  def start_link() do
    # NOTE(chaserx): remember that `&` notation is a shortcut to using `fn -> word_list() end`
    Agent.start_link(&word_list/0, name: @me)
  end

  def word_list do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end

  def random_word() do
    Agent.get(@me, &Enum.random/1)
  end
end
