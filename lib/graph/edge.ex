defmodule ExGraphs.Edge do
  @moduledoc """
  A struct representing an edge in a graph.

  Example:
    %Edge{u: u, v: v, weight: weight}
    # where u and v are vertices and weight is the weight of the edge (optional).
  """
  alias ExGraphs.Vertex

  @enforce_keys [:u, :v]
  defstruct [:u, :v, :weight]

  @doc """
  Creates an edge unidrected edge between two vertices.

  Returns:
    - `{:ok, edge, u, v}` if the edge was successfully created.
    - `{:error, u, v}` if the vertices are the same or already has an edge between them.
  """
  def create_edge(%ExGraphs.Vertex{} = u, %ExGraphs.Vertex{} = v, weight \\ 1) do
    {status, u, v} = Vertex.add_neighbor(u, v)

    case status do
      :ok -> {:ok, %ExGraphs.Edge{u: u, v: v, weight: weight}, u, v}
      :error -> {:error, u, v}
    end
  end
end
