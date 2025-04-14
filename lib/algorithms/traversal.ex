defmodule ExGraphs.Algorithms.Traversal do
  @moduledoc """
  A module for performing graph traversal algorithms.

  Implements the following algorithms:
    - Depth-First Search (DFS)
    - Breadth-First Search (BFS)
  Each algorithm is implemented as a function that takes a graph and a starting vertex index as arguments.
  """
  alias ExGraphs.{Vertex, Graph}

  def depth_first_search(%Graph{} = graph, %Vertex{} = start) do
    visited = MapSet.new()

    {_visited, result} = dfs(graph, start.index, visited, [])
    result |> Enum.reverse()
  end

  def depth_first_search(%Graph{} = graph, start) when is_integer(start) do
    visited = MapSet.new()

    {_visited, result} = dfs(graph, start, visited, [])
    result |> Enum.reverse()
  end

  @spec dfs(Graph.t(), integer(), MapSet.t(), list()) :: {MapSet.t(), list()}
  def dfs(%Graph{} = graph, current, visited, result) do
    # check if the current vertex exists in the graph
    case Graph.get_vertex(graph, current) do
      nil ->
        # if the vertex does not exist, return the current state
        {visited, result}

      _vertex ->
        if MapSet.member?(visited, current) do
          {visited, result}
        else
          # mark the current node as visited and add it to the result
          visited = MapSet.put(visited, current)
          result = [current | result]

          case Graph.neighbors(graph, current) do
            {:ok, neighbors} ->
              Enum.reduce(neighbors, {visited, result}, fn neighbor, {acc_visited, acc_result} ->
                dfs(graph, neighbor, acc_visited, acc_result)
              end)

            {:error, :vertex_not_found} ->
              {visited, result}
          end
        end
    end
  end
end
