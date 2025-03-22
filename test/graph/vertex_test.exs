defmodule ExGraphsTest.VertexTest do
  use ExUnit.Case

  alias ExGraphs.Vertex

  describe "Vertex struct and methods tests" do
    IO.puts("Running Vertex tests")

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

      assert {:ok, new_v1, new_v2} = Vertex.add_neighbor(v1, v2)

      assert new_v1.neighbors == [2]
      assert new_v2.neighbors == [1]
      assert new_v1.degree == 1
      assert new_v2.degree == 1
    end

    test "adding multiple neighbors updates correctly" do
      v1 = %Vertex{index: 1, label: "A"}
      v2 = %Vertex{index: 2, label: "B"}
      v3 = %Vertex{index: 3, label: "C"}

      assert {:ok, v1, v2} = Vertex.add_neighbor(v1, v2)
      assert {:ok, v1, v3} = Vertex.add_neighbor(v1, v3)
      assert {:ok, v2, v3} = Vertex.add_neighbor(v2, v3)

      # Order depends on list prepending
      assert v1.neighbors == [3, 2]
      assert v1.degree == 2

      assert v2.neighbors == [3, 1]
      assert v2.degree == 2

      assert v3.neighbors == [2, 1]
      assert v3.degree == 2
    end

    test "add_neighbor/2 returns an error if the vertices are already neighbors" do
      v1 = %Vertex{index: 1, label: "A"}
      v2 = %Vertex{index: 2, label: "B"}

      {status, v1, v2} = Vertex.add_neighbor(v1, v2)
      assert status == :ok
      assert v1.neighbors == [2]
      assert v2.neighbors == [1]

      assert Vertex.add_neighbor(v1, v2) == {:error, v1, v2}
    end

    test "add_neighbor/2 returns an error if the vertices are the same" do
      v1 = %Vertex{index: 1, label: "A"}

      assert Vertex.add_neighbor(v1, v1) == {:error, v1, v1}
    end

  end
end
