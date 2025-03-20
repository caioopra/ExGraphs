defmodule ExGraphs.Edge do
  @moduledoc """
  A struct representing an edge in a graph.

  Example:
    %Edge{u: u, v: v, weight: weight}
    # where u and v are vertices and weight is the weight of the edge (optional).
  """
  @enforce_keys [:u, :v]
  defstruct [:u, :v, :weight]
end
