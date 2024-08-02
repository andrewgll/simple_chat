defmodule SimpleChatWeb.ChatLive do
  use SimpleChatWeb, :live_view

  on_mount {SimpleChatWeb.UserAuth, :ensure_authenticated}

  def mount(_params, _session, socket) do
    {:ok, assign(socket, messages: [])}
  end

  def handle_event("send_message", %{"message" => message}, socket) do
    messages = socket.assigns.messages ++ [message]
    {:noreply, assign(socket, messages: messages)}
  end
end
