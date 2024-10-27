defmodule Lernmit.Locale do
  def on_mount(:default, _params, session, socket) do
    Gettext.put_locale(LernMitWeb.Gettext, "de")
    {:cont, socket}
  end

end