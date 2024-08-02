defmodule SimpleChatWeb.RegistrationComponent do
  use SimpleChatWeb, :live_component

  alias SimpleChat.Accounts.User
  alias SimpleChat.Accounts

  import SimpleChatWeb.FormHelpers

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm">
      <.header class="mt-14">
        Register for an account
        <:subtitle>
          Already registered?
          <button
            phx-click="navigate_to_login"
            phx-target={@myself}
            class="font-semibold text-brand hover:underline"
          >
            Log in
          </button>
          to your account now.
        </:subtitle>
      </.header>
      <.simple_form
        for={@form}
        id="registration_form"
        phx-submit="save"
        phx-target={@myself}
        phx-change="validate"
      >
        <.input field={@form[:username]} type="text" label="Username" required />
        <%!-- phx-debounce="blur ensures that validation occured only after field looses focus --%>
        <.input
          field={@form[:password]}
          type="password"
          label="Password"
          required
          phx-debounce="blur"
        />
        <:actions>
          <.button phx-disable-with="Creating account..." class="w-full">Create an account⚡</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def mount(socket) do
    changeset = Accounts.change_user_registration(%User{})

    socket =
      socket
      |> assign_form(changeset)

    {:ok, socket, temporary_assigns: [form: nil, check_errors: nil]}
  end

  def handle_event("navigate_to_login", _params, socket) do
    send(self(), {:navigate_to_login})
    {:noreply, socket}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        changeset = Accounts.change_user_registration(user)
        send(self(), {:registration_success, user.username})

        {:noreply,
         socket
         |> assign_form(changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
         socket
         |> assign(:check_errors, true)
         |> assign_form(changeset)}
    end
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset = Accounts.change_user_registration(%User{}, user_params)
    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end


end
