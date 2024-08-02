defmodule SimpleChatWeb.LeftPartComponent do
  use SimpleChatWeb, :live_component
  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-xl">
      <h1 class="text-brand mt-10 flex items-center text-sm font-semibold leading-6">
        Sooqa Web Chat
        <small class="bg-brand/5 text-[0.8125rem] ml-3 rounded-full px-2 font-medium leading-6">
          v1.0
        </small>
      </h1>
      <p class="text-[2rem] mt-4 font-semibold leading-10 tracking-tighter text-zinc-900 text-balance">
        The simplest Live Chat⚡
      </p>
      <p class="mt-4 text-base leading-7 text-zinc-600">
        This application is completely built using web sockets.
      </p>
      <p class="mt-4 text-base leading-7 text-zinc-600">
      Moreover, this chat can serve up to 10,000 users simultaneously
      </p>
      <p class="text-base leading-7 text-zinc-600">
        Wondering how I did it? <.link
          navigate="https://www.linkedin.com/in/andrii-hladkyi-ml/"
          class=" text-brand hover:underline"
        >
          Write me
        </.link>.
      </p>
    </div>
    """
  end
end
