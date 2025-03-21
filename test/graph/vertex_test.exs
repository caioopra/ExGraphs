defmodule ExGraphsTest.VertexTest do
  use ExUnit.Case

  alias ExGraphs.Vertex

  describe "Vertex struct and methods tests" do
    test "creates a vertex" do
      vertex = %ExGraphs.Vertex{index: 1, label: "A", neighbors: [], degree: 0}
      assert vertex.index == 1
      assert vertex.label == "A"
      assert vertex.neighbors == []
      assert vertex.degree == 0
    end

    test "creates a vertex with neighbors" do
      vertex = %ExGraphs.Vertex{index: 1, label: "A", neighbors: [2, 3], degree: 2}
      assert vertex.index == 1
      assert vertex.label == "A"
      assert vertex.neighbors == [2, 3]
      assert vertex.degree == 2
    end

    test "add_neighbor/2 correctly adds neighbors and updates degrees" do
      v1 = %Vertex{index: 1, label: "A"}
      v2 = %Vertex{index: 2, label: "B"}

      {new_v1, new_v2} = Vertex.add_neighbor(v1, v2)

      assert new_v1.neighbors == [2]
      assert new_v2.neighbors == [1]
      assert new_v1.degree == 1
      assert new_v2.degree == 1

      IO.inspect(new_v1)
      IO.inspect(new_v2)
    end
  end
end
