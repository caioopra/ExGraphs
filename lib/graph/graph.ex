defmodule ExGraphs.Graph do
  @moduledoc """
  A struct representing a graph.

  Has two maps as fields:
    - vertices: a map of vertices in the graph (index of the vertex as key).
    - edges: a map of edges in the graph ((u.index, v.index) as key).

  Main methods:
    - `create_vertex`: given the graph, an index and the label (optional), tries to inserts a graph into the graph
  """
  defstruct vertices: %{}, edges: %{}

  @type t :: %__MODULE__{
          vertices: %{integer() => ExGraphs.Vertex.t()},
          edges: %{integer() => ExGraphs.Edge.t()}
        }

  @spec insert_vertex(%ExGraphs.Graph{}, ExGraphs.Vertex.t()) ::
          {:ok, %ExGraphs.Graph{}} | {:error, %ExGraphs.Graph{}}
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

  @spec create_vertex(ExGraphs.Graph.t(), integer(), String.t()) ::
          {:ok, %ExGraphs.Graph{edges: term(), vertices: term()}}
          | {:error, %ExGraphs.Graph{edges: term(), vertices: term()}}
  @doc """
  Inserts an edge into the graph. If the edge already exists, returns an error.

  Returns:
    - `{:ok, updated_graph}` if the vertex was successfully addded
    - `{:error, graph}` if couldn't insert it
  """
  def create_vertex(%ExGraphs.Graph{} = graph, index, label) do
    vertex = %ExGraphs.Vertex{index: index, label: label}
    insert_vertex(graph, vertex)
  end

  @spec create_vertex(ExGraphs.Graph.t(), integer()) ::
          {:ok, %ExGraphs.Graph{edges: term(), vertices: term()}}
          | {:error, %ExGraphs.Graph{edges: term(), vertices: term()}}
  def create_vertex(%ExGraphs.Graph{} = graph, index) do
    create_vertex(graph, index, to_string(index))
  end

  # getting usefull information about vertices and edges
  def vertices_amount(%ExGraphs.Graph{vertices: vertices} = _graph) do
    vertices
    |> Map.keys()
    |> Enum.count()
  end
end
