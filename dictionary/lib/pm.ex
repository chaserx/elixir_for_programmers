defmodule Pm do
  def swapper({a, b}) do
    {b, a}
  end

  def equalizer(a, a) do
    true
  end

  def equalizer(_a, _b) do
    false
  end
end
