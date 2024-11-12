defmodule LernmitWeb.CardController do
  use LernmitWeb, :controller

  alias Lernmit.Cards

  action_fallback LernmitWeb.FallbackController

  def index(conn, _params) do
    json(conn, [%{term: "", definition: ""}])
  end

  def show(conn, %{"id" => id}) do
    card = Cards.list_card(id)
    json(conn, card)
  end
end
