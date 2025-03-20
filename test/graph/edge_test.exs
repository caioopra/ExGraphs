defmodule ExGraphsTest.EdgeTest do
  use ExUnit.Case

  describe "Edge struct and methods tests" do
    test "creates an Edge" do
      u = %ExGraphs.Vertex{index: 1, label: "A"}
      v = %ExGraphs.Vertex{index: 2, label: "B"}
      edge = %ExGraphs.Edge{u: u, v: v}

      assert edge.u == u
      assert edge.v == v
    end
  end
end
