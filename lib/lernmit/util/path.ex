defmodule Lernmit.Util.Path do
  @moduledoc """
  Helper functions for working with paths.
  """

  @doc """
  Returns the current path of the given socket.

  ## Example

      iex> current_path(socket, "Month")
      true
  """
  def current_path?(socket, path) do
    if String.downcase(to_string(socket.view)) |> String.contains?(String.downcase(path)) do
      true
    else
      false
    end
  end
end