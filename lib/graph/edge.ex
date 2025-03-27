defmodule ExGraphs.Edge do
  @moduledoc """
  A struct representing an edge in a graph.

  Example:
    %Edge{u: u, v: v, weight: weight}
    # where u and v are vertices and weight is the weight of the edge (optional).
  """
  alias ExGraphs.{Vertex, Edge}

  @enforce_keys [:u, :v]
  defstruct [:u, :v, :weight]

  @type t :: %__MODULE__{
          u: Vertex.t(),
          v: Vertex.t(),
          weight: number()
        }

  @spec create_edge(Vertex.t(), Vertex.t()) ::
          {:error, nil, Vertex.t(), Vertex.t()}
          | {:ok, Edge.t(), Vertex.t(), Vertex.t()}
  @doc """
  Creates an unidrected edge between two vertices.
  Should be used for creating edges, instead of manually building the struct, since this function already updates the degree and neighbors of the vertices.

  Returns:
    - `{:ok, edge, u, v}` if the edge was successfully created.
    - `{:error, nil, u, v}` if the vertices are the same or already has an edge between them.
  """
  def create_edge(%Vertex{} = u, %Vertex{} = v, weight \\ 1) do
    {status, u, v} = Vertex.add_neighbor(u, v)

    case status do
      :ok -> {:ok, %Edge{u: u, v: v, weight: weight}, u, v}
      :error -> {:error, nil, u, v}
    end
  end
end
