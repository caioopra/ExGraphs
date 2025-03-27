defmodule ExGraphsTest.EdgeTest do
  use ExUnit.Case

  alias ExGraphs.{Vertex, Edge}

  describe "Edge struct and methods tests" do
    IO.puts("Running Edge tests")

    test "Edge.create_edge/2 creates an edge between two vertices" do
      v1 = %Vertex{index: 1, label: "A"}
      v2 = %Vertex{index: 2, label: "B"}

      assert {:ok, edge, new_v1, new_v2} = Edge.create_edge(v1, v2)

      assert edge.u.index == 1
      assert edge.v.index == 2
      assert edge.weight == 1

      assert new_v1.neighbors == [2]
      assert new_v2.neighbors == [1]
    end

    test "Edge.create_edge/2 creates an edge with a custom weight" do
      v1 = %Vertex{index: 1, label: "A"}
      v2 = %Vertex{index: 2, label: "B"}

      assert {:ok, edge, _new_v1, _new_v2} = Edge.create_edge(v1, v2, 3.5)

      assert edge.weight == 3.5
    end

    test "Edge.create_edge/2 returns error when trying to create a self-loop" do
      v1 = %Vertex{index: 1, label: "A"}

      assert {:error, nil, v1, v1} = Edge.create_edge(v1, v1)
    end

    test "Edge.create_edge/2 returns error when creating an existing edge" do
      v1 = %Vertex{index: 1, label: "A"}
      v2 = %Vertex{index: 2, label: "B"}

      {:ok, _edge, v1, v2} = Edge.create_edge(v1, v2)

      assert {:error, nil, ^v1, ^v2} = Edge.create_edge(v1, v2)
    end
  end
end
