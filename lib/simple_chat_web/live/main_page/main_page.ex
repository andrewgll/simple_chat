defmodule SimpleChatWeb.MainPageLive do
  use SimpleChatWeb, :live_view

  def render(assigns) do
    ~H"""
    <.flash_group flash={@flash} />
    <div class="px-4 py-4 sm:px-6 sm:py-28 lg:px-8 xl:px-28 xl:py-32 flex justify-between">
      <.live_component module={SimpleChatWeb.LeftPartComponent} id="left-part" />
      <div class="border-r-2 border-zinc-100 pl-5 mr-5"></div>
      <%= if @action == :logging do %>
        <.live_component
          module={SimpleChatWeb.UserLoginComponent}
          username={@username}
          id="user-logging"
        />
      <% else %>
        <.live_component module={SimpleChatWeb.RegistrationComponent} id="registration" />
      <% end %>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(user_logged_in: nil)
      |> assign(username: nil)
      |> assign(action: :registration)

    {:ok, socket}
  end

  def handle_info({:registration_success, username}, socket) do
    {:noreply,
     socket
     |> assign(:username, username)
     |> assign(:action, :logging)}
  end

  def handle_info({:navigate_to_login}, socket) do
    {:noreply, assign(socket, action: :logging)}
  end

  def handle_info({:navigate_to_register}, socket) do
    {:noreply, assign(socket, action: :registration)}
  end

  def handle_info({:user_logged_in, %{token: token, user: user}}, socket) do
    {:noreply,
     socket
     |> assign(:token, token)
     |> assign(:login_error, false)
     |> assign(:user_logged_in, user)}
  end

  def handle_event("navigate_to_login", _params, socket) do
    {:noreply, assign(socket, action: :logging)}
  end

  def handle_event("navigate_to_register", _params, socket) do
    {:noreply, assign(socket, action: :registration)}
  end

  def assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "user")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end
end
