defmodule SimpleChatWeb.ChatLive do
  use SimpleChatWeb, :live_view

  on_mount {SimpleChatWeb.UserAuth, :ensure_authenticated}

  def mount(_params, _session, socket) do
    {:ok, assign(socket, messages: [])}
  end

  def handle_event("send_message", %{"message" => message}, socket) do
    trimmed_message = String.trim(message)

    if trimmed_message != "" do
      messages = socket.assigns.messages ++ [trimmed_message]
      {:noreply, assign(socket, messages: messages)}
    else
      {:noreply, socket}
    end
  end
end
