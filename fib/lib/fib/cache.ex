defmodule Fib.Cache do
  def start(func) do
    {:ok, pid} = Agent.start_link(fn -> %{0 => 0, 1 => 1} end)
    func_result = func.(pid)
    Agent.stop(pid)
    func_result
  end

  def get(cache, n, func_if_not_found) do
    Agent.get(cache, fn map -> map[n] end)
    |> calculate_if_not_found(cache, n, func_if_not_found)
  end

  def set(value, cache, n) do
    Agent.get_and_update(cache, fn map -> {value, Map.put(map, n, value)} end)
  end

  defp calculate_if_not_found(nil, cache, n, func_if_not_found) do
    func_if_not_found.()
    |> set(cache, n)
  end

  defp calculate_if_not_found(value, _cache, _n, _func_if_not_found) do
    value
  end
end
