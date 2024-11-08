defmodule Lernmit.Util.Message do
  @moduledoc """
  Gives common phrases for informative messages.
  """

  import LernmitWeb.Gettext

  @doc """
  Messages for the UI where a bad request is made.

  message(:unauthorized) returns "Unauthorized"
  """
  def error(:unauthorized), do: gettext("Unauthorized")
  def error(:not_found), do: gettext("Item not found")
end
