defmodule PokeTabWeb.LiveDashboard.Pokemon do
  @moduledoc false
  use Phoenix.LiveDashboard.PageBuilder

  @impl true
  def menu_link(_, _) do
    {:ok, "Pokédex"}
  end

  @impl true
  def mount(_params, _session, socket) do
    pokemon = fetch_random_pokemon()

    {:ok, assign(socket, pokemon: pokemon)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.row>
      <:col>
        <.card title={"#{@pokemon.name} ##{@pokemon.id}"} hint="something">
          <img src={@pokemon.image} alt={@pokemon.name} />
        </.card>
      </:col>
      <:col>
        <.row>
          <:col>
            <.card title="Weight">
              <%= @pokemon.weight %>
            </.card>
          </:col>
          <:col>
            <.card title="Height">
              <%= @pokemon.height %>
            </.card>
          </:col>
          <:col>
            <.card title="Base XP">
              <%= @pokemon.base_xp %>
            </.card>
          </:col>
        </.row>
        <.row>
          <:col>
            <.fields_card title="Types" fields={@pokemon.types} />
          </:col>
        </.row>

        <.row>
          <:col>
            <.card_title title="Game Sprites" />
          </:col>
        </.row>
        <.row>
          <:col>
            <.card>
              <img src={@pokemon.sprites["front_default"]} />
            </.card>
          </:col>
          <:col>
            <.card>
              <img src={@pokemon.sprites["front_shiny"]} />
            </.card>
          </:col>
        </.row>
      </:col>
    </.row>
    """
  end

  defp fetch_random_pokemon do
    body = Req.get!("https://pokeapi.co/api/v2/pokemon/#{Enum.random(1..1010)}").body

    %{
      name: String.capitalize(body["name"]),
      id: body["id"],
      weight: body["weight"],
      height: body["height"],
      base_xp: body["base_experience"] || "?",
      types: list_types(body["types"]),
      image: body["sprites"]["other"]["official-artwork"]["front_default"],
      sprites: body["sprites"]
    }
  end

  defp list_types(types),
    do: Enum.map(types, fn %{"type" => %{"name" => name}} -> {nil, name} end)
end
