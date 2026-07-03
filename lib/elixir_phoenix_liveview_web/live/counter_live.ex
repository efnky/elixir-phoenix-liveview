defmodule ElixirPhoenixLiveviewWeb.CounterLive do
  use ElixirPhoenixLiveviewWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, count: 0)}
  end

  @impl true
  def handle_event("inc", _params, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div style="padding: 2rem; font-family: sans-serif">
      <h1>elixir-phoenix-liveview</h1>
      <p>Phoenix LiveView (uzun ömürlü WebSocket) — count: <%= @count %></p>
      <button phx-click="inc" style="padding: .5rem 1rem">+1</button>
    </div>
    """
  end
end
