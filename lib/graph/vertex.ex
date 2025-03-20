defmodule ExGraphs.Vertex do
  @moduledoc """
  A struct representing a vertex in a graph.
  """
  @enforce_keys [:index, :label]
  defstruct [:index, :label, :neighbors, :degree]

  def add_neighbor(%ExGraphs.Vertex{} = u, %ExGraphs.Vertex{} = v) do
    add_neighbor_to_vertex(u, u)
    add_neighbor_to_vertex(v, v)
  end

  defp add_neighbor_to_vertex(vertex, neighbor) do
    vertex
    |> Map.update(:neighbors, [neighbor], &(&1 ++ [neighbor]))
    |> Map.update(:degree, 1, &(&1 + 1))
  end
end
