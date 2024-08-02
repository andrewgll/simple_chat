defmodule SimpleChat.Accounts.UserNotifier do
  import Swoosh.Email

  alias SimpleChat.Mailer

  # Delivers the username using the application mailer.
  defp deliver(recipient, subject, body) do
    username =
      new()
      |> to(recipient)
      |> from({"SimpleChat", "contact@example.com"})
      |> subject(subject)
      |> text_body(body)

    with {:ok, _metadata} <- Mailer.deliver(username) do
      {:ok, username}
    end
  end

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(user, url) do
    deliver(user.username, "Confirmation instructions", """

    ==============================

    Hi #{user.username},

    You can confirm your account by visiting the URL below:

    #{url}

    If you didn't create an account with us, please ignore this.

    ==============================
    """)
  end

  @doc """
  Deliver instructions to reset a user password.
  """
  def deliver_reset_password_instructions(user, url) do
    deliver(user.username, "Reset password instructions", """

    ==============================

    Hi #{user.username},

    You can reset your password by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """)
  end

  @doc """
  Deliver instructions to update a user username.
  """
  def deliver_update_username_instructions(user, url) do
    deliver(user.username, "Update username instructions", """

    ==============================

    Hi #{user.username},

    You can change your username by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """)
  end
end
