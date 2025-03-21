defmodule ExGraphs.Vertex do
  @moduledoc """
  A struct representing a vertex in a graph.
  """
  @enforce_keys [:index, :label]
  defstruct [:index, :label, neighbors: [], degree: 0]

  @doc """
  Adds an undirected edge between two vertices.
  Returns the updated vertices, ensuring each references the updated version of the other.
  """
  def add_neighbor(%ExGraphs.Vertex{} = u, %ExGraphs.Vertex{} = v) do
    updated_u = %ExGraphs.Vertex{u | neighbors: [v.index | u.neighbors], degree: u.degree + 1}
    updated_v = %ExGraphs.Vertex{v | neighbors: [u.index | v.neighbors], degree: v.degree + 1}

    {updated_u, updated_v}
  end
end
