# TODO: Remove when upstream Pow can handle LiveView/socket auth
defmodule LernmitWeb.Pow.SocketAuth do
  @moduledoc """
  LiveView authentication assigns @current_user to the socket
  @link https://github.com/pow-auth/pow/issues/706
  """
  use Phoenix.LiveView
  use LernmitWeb, :verified_routes

  def on_mount(:default, _params, session, socket) do
    socket = mount_current_user(socket, session)

    if socket.assigns.current_user do
      {:cont, socket}
    else
      socket =
        socket
        |> Phoenix.LiveView.put_flash(:error, "You must be logged in to access this page.")
        |> Phoenix.LiveView.redirect(to: ~p"/")

      {:halt, socket}
    end
  end

  defp mount_current_user(socket, session) do
    Phoenix.Component.assign_new(socket, :current_user, fn ->
      {_conn, user} =
        %Plug.Conn{
          private: %{
            plug_session_fetch: :done,
            plug_session: session,
            pow_config: [otp_app: :lernmit]
          },
          owner: self(),
          remote_ip: {0, 0, 0, 0}
        }
        |> Map.put(:secret_key_base, LernmitWeb.Endpoint.config(:secret_key_base))
        |> Pow.Plug.Session.fetch(otp_app: :lernmit)

      user
    end)
  end
end
