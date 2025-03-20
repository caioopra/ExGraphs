defmodule ExGraphs.Graph.Vertex do
  @enforce_keys [:index]
  defstruct [:index, :label, :neighbors, :degree]

  def add_neighbor(vertex, neighbor) do
    add_neighbor_to_vertex(vertex, neighbor)
    add_neighbor_to_vertex(neighbor, vertex)
  end

  defp add_neighbor_to_vertex(vertex, neighbor) do
    vertex
    |> Map.update(:neighbors, [neighbor], &(&1 ++ [neighbor]))
    |> Map.update(:degree, 1, &(&1 + 1))
  end
end
