defmodule SimpleChatWeb.UserConfirmationInstructionsLive do
  use SimpleChatWeb, :live_view


  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm">
      <.header class="text-center">
        No confirmation instructions received?
        <:subtitle>We'll send a new confirmation link to your inbox</:subtitle>
      </.header>

      <.simple_form for={@form} id="resend_confirmation_form" phx-submit="send_instructions">
        <.input field={@form[:username]} type="username" placeholder="Username" required />
        <:actions>
          <.button phx-disable-with="Sending..." class="w-full">
            Resend confirmation instructions
          </.button>
        </:actions>
      </.simple_form>

      <p class="text-center mt-4">
        <%!-- <.link href={~p"/users/register"}>Register</.link>
        | <.link href={~p"/users/log_in"}>Log in</.link> --%>
      </p>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}, as: "user"))}
  end

  # def handle_event("send_instructions", %{"user" => %{"username" => username}}, socket) do
  #   # if user = Accounts.get_user_by_username(username) do
  #   #   Accounts.deliver_user_confirmation_instructions(
  #   #     user,
  #   #     &url(~p"/users/confirm/#{&1}")
  #   #   )
  #   # end

  #   info =
  #     "If your username is in our system and it has not been confirmed yet, you will receive an username with instructions shortly."

  #   {:noreply,
  #    socket
  #    |> put_flash(:info, info)
  #    |> redirect(to: ~p"/")}
  # end
end
