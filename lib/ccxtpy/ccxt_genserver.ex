defmodule Ccxtex.Port do
  use Export.Python
  use GenServer

  @doc """
  Handles start and initialization of port process to call python programs.
  """

  def start_link(name, _opts \\ []) do
    app_dir = Application.app_dir(:ccxtex)
    Python.start(name, python: "python3", python_path: Path.expand(app_dir <> "/priv/python"))
  end

  def init(args) do
    {:ok, args}
  end

  def child_spec(args) do
    [name] = args
    %{
      id: name,
      start: {__MODULE__, :start_link, args}
    }
  end
end
