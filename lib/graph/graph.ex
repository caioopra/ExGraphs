defmodule ExGraphs.Graph do
  @moduledoc """
  A struct representing a graph.

  Has two maps as fields:
    - vertices: a map of vertices in the graph (index of the vertex as key).
    - edges: a map of edges in the graph ((u.index, v.index) as key).
  """
  defstruct [:vertices, :edges]

  @doc """
  Inserts a vertex into the graph. If the vertex already exists, returns an error.

  Returns:
    - `{:ok, updated_graph}` if the vertex was successfully added.
    - `{:error, graph}` if the vertex already exists.
  """
  def insert_vertex(%ExGraphs.Graph{} = graph, %ExGraphs.Vertex{} = vertex) do
    cond do
      Map.has_key?(graph.vertices, vertex.index) ->
        {:error, graph}

      true ->
        updated_vertices = Map.put(graph.vertices, vertex.index, vertex)
        {:ok, %ExGraphs.Graph{graph | vertices: updated_vertices}}
    end
  end
end
