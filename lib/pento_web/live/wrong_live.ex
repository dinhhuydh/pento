defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, message: "Guess a number", winning_number: :rand.uniform(10))}
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    IO.inspect(socket.assigns)
    IO.inspect(socket.assigns.winning_number)
    IO.inspect(guess)
    IO.inspect(Integer.parse(guess))

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
    """
  end
end
