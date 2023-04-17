defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, session, socket) do
    {:ok,
     assign(socket,
       score: 0,
       message: "Guess a number",
       winning_number: :rand.uniform(10),
       user: Pento.Accounts.get_user_by_session_token(session["user_token"]),
       session_id: session["live_socket_id"]
     )}
  end

  def handle_event("guess", %{"number" => guess} = _data, socket) do
    if String.to_integer(guess) == socket.assigns.winning_number do
      message = "Your guess: #{guess}. Correct. Congrats."
      score = socket.assigns.score + 100

      {
        :noreply,
        assign(
          socket,
          message: message,
          score: score
        )
      }
    else
      message = "Your guess: #{guess}. Wrong. Guess again. "
      score = socket.assigns.score - 1

      {
        :noreply,
        assign(
          socket,
          message: message,
          score: score
        )
      }
    end
  end

  def render(assigns) do
    ~L"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number="<%= n %>"><%= n %></a>
      <% end %>
    </h2>
    <pre>
      <%= @user.email %>
      <%= @session_id %>
    </pre>
    """
  end
end
