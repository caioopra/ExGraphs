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

  alias ExGraphs.{Vertex, Edge, Graph}

  @type t :: %__MODULE__{
          vertices: %{integer() => Vertex.t()},
          edges: %{integer() => Edge.t()}
        }

  @spec insert_vertex(Graph.t(), Vertex.t()) ::
          {:ok, Graph.t()} | {:error, Graph.t()}
  @doc """
  Inserts a vertex into the graph. If the vertex already exists, returns an error.

  Returns:
    - `{:ok, updated_graph}` if the vertex was successfully added.
    - `{:error, graph}` if the vertex already exists.
  """
  def insert_vertex(%Graph{} = graph, %Vertex{} = vertex) do
    cond do
      Map.has_key?(graph.vertices, vertex.index) ->
        {:error, graph}

      true ->
        updated_vertices = Map.put(graph.vertices, vertex.index, vertex)
        {:ok, %Graph{graph | vertices: updated_vertices}}
    end
  end

  @spec create_vertex(Graph.t(), integer(), String.t()) ::
          {:ok, Graph.t()}
          | {:error, Graph.t()}
  @doc """
  Inserts an edge into the graph. If the edge already exists, returns an error.

  Returns:
    - `{:ok, updated_graph}` if the vertex was successfully addded
    - `{:error, graph}` if couldn't insert it
  """
  def create_vertex(%Graph{} = graph, index, label) do
    vertex = %Vertex{index: index, label: label}
    insert_vertex(graph, vertex)
  end

  @spec create_vertex(Graph.t(), integer()) ::
          {:ok, Graph.t()}
          | {:error, Graph.t()}
  def create_vertex(%Graph{} = graph, index) do
    create_vertex(graph, index, to_string(index))
  end

  # getting usefull information about vertices and edges
  @spec vertices_amount(Graph.t()) :: non_neg_integer()
  @doc """
  Gets the amount of vertices in the graph.
  """
  def vertices_amount(%Graph{vertices: vertices} = _graph) do
    vertices
    |> Map.keys()
    |> Enum.count()
  end

  @spec edges_amount(Graph.t()) :: non_neg_integer()
  @doc """
  Gets the amount of edges in the graph.
  """
  def edges_amount(%Graph{edges: edges} = _graph) do
    edges
    |> Map.keys()
    |> Enum.count()
  end
end
