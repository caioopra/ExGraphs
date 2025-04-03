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

  @doc """
  Create and insert an Edge into the graph when the vertices are already in the graph.
  """
  def create_edge(%Graph{} = graph, %Vertex{} = u, %Vertex{} = v, weight \\ 1) do
    cond do
      # check if the vertices are already in the graph
      not vertex_in_graph?(graph, u.index) or not vertex_in_graph?(graph, v.index) ->
        {:error, graph, u, v}

      # check if the edge already exists
      has_edge?(graph, u, v) ->
        {:error, graph, u, v}

      # else, create the edge
      true ->
        {:ok, edge, u, v} = Edge.create_edge(u, v, weight)

        {:ok, updated_graph} = insert_edge(graph, edge)

        {:ok, updated_graph, u, v}
    end
  end

  @doc """
  Inserts an edge into the graph. If the edge already exists, returns an error.
  Prefere using `create_edge/3` instead of this function.
  """
  def insert_edge(%Graph{} = graph, %Edge{} = edge) do
    key = {edge.u.index, edge.v.index}

    if Map.has_key?(graph.edges, key) do
      {:error, graph}
    else
      {:ok, %Graph{graph | edges: Map.put(graph.edges, key, edge)}}
    end
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

  def vertex_in_graph?(%Graph{vertices: vertices}, index) when is_integer(index) do
    Map.has_key?(vertices, index)
  end

  # TODO: this is considering that the graph is undirected; if the graph is directed, this function should be changed
  @spec has_edge?(Graph.t(), Vertex.t(), Vertex.t()) :: boolean()
  def has_edge?(
        %Graph{edges: edges} = _graph,
        %Vertex{index: u_index} = _u,
        %Vertex{index: v_index} = _v
      ) do
    Map.has_key?(edges, {u_index, v_index}) or Map.has_key?(edges, {v_index, u_index})
  end

  @spec has_edge?(Graph.t(), integer(), integer()) :: boolean()
  def has_edge?(%Graph{edges: edges} = _graph, u_index, v_index) do
    Map.has_key?(edges, {u_index, v_index}) or Map.has_key?(edges, {v_index, u_index})
  end

  @spec get_vertex(Graph.t(), integer()) :: Vertex.t() | nil
  def get_vertex(%Graph{vertices: vertices}, index) do
    Map.get(vertices, index)
  end
end
