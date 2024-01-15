defmodule PokeTabWeb.LiveDashboard.Pokemon do
  @moduledoc false
  use Phoenix.LiveDashboard.PageBuilder

  @impl true
  def menu_link(_, _) do
    {:ok, "Pokémon"}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>Gotta catch 'em all!</div>
    """
  end
end
