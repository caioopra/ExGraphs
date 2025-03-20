defmodule ExGraphs.Graph.Edge do
  alias ExGraphs.Graph.Edge

  @enforce_keys [:u, :v]
  defstruct [:u, :v, :weight]

  def create(u, v, weight \\ 1) do
    

    %Edge{u: u, v: v, weight: weight}
  end

end
