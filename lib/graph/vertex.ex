defmodule ExGraphs.Vertex do
  @moduledoc """
  A struct representing a vertex in a graph.

  Example of creation of a vertex:
    vertex = %Vertex{index: 1, label: "A"}

  The neighbors and degree fields shouldn't be set manually, instead use the appropriate methods for adding/removing neighbors.
  """
  @enforce_keys [:index, :label]
  defstruct [:index, :label, neighbors: [], degree: 0]

  @doc """
  Adds an undirected edge between two vertices.

  Returns:
  - `{:ok, updated_u, updated_v}` if the edge was successfully added.
  - `{:error, u, v}` if they are already neighbors or the same vertex.
  """
  def add_neighbor(%ExGraphs.Vertex{} = u, %ExGraphs.Vertex{} = v) do
    cond do
      # prevent self-loops
      u.index == v.index ->
        {:error, u, v}

      # won't duplicate entries
      v.index in u.neighbors or u.index in v.neighbors ->
        {:error, u, v}

      true ->
        {updated_u, updated_v} = update_neighbors(u, v)
        {:ok, updated_u, updated_v}
    end
  end

  defp update_neighbors(%ExGraphs.Vertex{} = u, %ExGraphs.Vertex{} = v) do
    updated_u = %ExGraphs.Vertex{u | neighbors: [v.index | u.neighbors], degree: u.degree + 1}

    updated_v = %ExGraphs.Vertex{v | neighbors: [u.index | v.neighbors], degree: v.degree + 1}

    {updated_u, updated_v}
  end
end
