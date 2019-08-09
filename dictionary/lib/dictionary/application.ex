defmodule Dictionary.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Dictionary.WordList, []),
    ]

    options = [
      name: Dictionary.Supervisor,
      strategy: :one_for_one,
    ]

    # start a supervisor with a list of child processes
    Supervisor.start_link(children, options)
  end
end
