defmodule SimpleChatWeb.UserLoginComponent do
  use SimpleChatWeb, :live_component

  alias SimpleChat.Accounts.User
  alias SimpleChat.Accounts

  import SimpleChatWeb.FormHelpers

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm">
      <.header class="mt-14">
        Log in to your account
        <:subtitle>
          Don't have an account?
          <button
            phx-click="navigate_to_register"
            phx-target={@myself}
            class="font-semibold text-brand hover:underline"
          >
            Create an account
          </button>
          now.
        </:subtitle>
      </.header>

      <.simple_form for={@form} id="login_form" action={~p"/user/log_in"} phx-update="ignore">
        <.input field={@form[:username]} type="text" label="Username" value={@username} required />
        <%!-- phx-debounce="blur ensures that validation occured only after field looses focus --%>
        <.input field={@form[:password]} type="password" label="Password" required />
        <:actions>
          <.button phx-disable-with="Creating account..." class="w-full">Sign In⚡</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def on_mount(:default, _params, %{"user_token" => user_token} = _session, socket) do
    socket =
      assign_new(socket, :current_user, fn ->
        Accounts.get_user_by_session_token(user_token)
      end)

    if socket.assigns.current_user.confirmed_at do
      {:cont, socket}
    else
      {:halt, redirect(socket, to: "/login")}
    end
  end

  def mount(socket) do
    changeset = Accounts.change_user_registration(%User{})

    socket =
      socket
      |> assign_form(changeset)

    {:ok, socket, temporary_assigns: [form: nil, check_errors: nil]}
  end

  def handle_event("navigate_to_register", _params, socket) do
    send(self(), {:navigate_to_register})
    {:noreply, socket}
  end

  # def handle_event("login", %{"user" => user_params}, socket) do
  #   %{"username" => username, "password" => password} = user_params

  #   case Accounts.get_user_by_username_and_password(username, password) do
  #     nil ->
  #       # Prevent user enumeration attacks and avoid disclosing which part failed
  #       changeset = Accounts.change_user_registration(%User{})
  #       {:noreply, assign_form(socket, changeset) |> assign(:login_error, true)}
  #     user ->

  #       token = Accounts.generate_user_session_token(user)
  #       socket =
  #         socket
  #         |> assign(:login_error, false)
  #         |> push_event("user_logged_in", %{token: token, user: user})

  #       send(self(), {:user_logged_in, %{token: token, user: user}})
  #       {:noreply, assign(socket, :login_error, false)}
  #   end
  # end

end
