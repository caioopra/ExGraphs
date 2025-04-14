defmodule ExGraphs.Algorithms.Travesal do
  use ExUnit.Case

  alias ExGraphs.{Graph, Vertex, Utils}

  describe "DFS tests" do
    setup do
      graph = %Graph{
        vertices: %{
          1 => %Vertex{index: 1, neighbors: [2, 3], label: "Vertex 1"},
          2 => %Vertex{index: 2, neighbors: [4], label: "Vertex 2"},
          3 => %Vertex{index: 3, neighbors: [], label: "Vertex 3"},
          4 => %Vertex{index: 4, neighbors: [], label: "Vertex 4"}
        }
      }

      %{graph: graph}
    end

    test "DFS traversal from vertex 1", %{graph: graph} do
      result =
        ExGraphs.Algorithms.Traversal.depth_first_search(graph, 1)

      assert result == [1, 2, 4, 3]
    end

    test "DFS traversal from vertex struct", %{graph: graph} do
      start_vertex = %Vertex{index: 1, neighbors: [2, 3], label: "Vertex 1"}

      result =
        ExGraphs.Algorithms.Traversal.depth_first_search(graph, start_vertex)

      assert result == [1, 2, 4, 3]
    end

    test "DFS traversal from non-existent vertex" do
      graph = %Graph{
        vertices: %{
          1 => %Vertex{index: 1, neighbors: [2, 3], label: "Vertex 1"},
          2 => %Vertex{index: 2, neighbors: [4], label: "Vertex 2"},
          3 => %Vertex{index: 3, neighbors: [], label: "Vertex 3"},
          4 => %Vertex{index: 4, neighbors: [], label: "Vertex 4"}
        }
      }

      result =
        ExGraphs.Algorithms.Traversal.depth_first_search(graph, 5)

      assert result == []
    end

    test "DFS traversal on empty graph" do
      graph = %Graph{vertices: %{}}

      result =
        ExGraphs.Algorithms.Traversal.depth_first_search(graph, 1)

      assert result == []
    end
  end

  describe "DFS tests with real-world graph" do
    setup do
      # Read the graph from the adjnoun.net file
      {:ok, graph} = Utils.read_graph("assets/adjnoun.net")
      %{graph: graph}
    end

    test "DFS traversal from vertex 1 with benchmark", %{graph: graph} do
      # Benchmark the DFS traversal
      {time_in_microseconds, result} =
        :timer.tc(fn ->
          ExGraphs.Algorithms.Traversal.depth_first_search(graph, 1)
        end)

      # Convert time to seconds
      time_in_milliseconds = time_in_microseconds / 1_000

      # Output the benchmark result
      IO.puts("DFS traversal took #{time_in_milliseconds} milliseconds")

      # Assert that the result contains all vertices in the graph
      assert length(result) == 112

      # Optionally, check that vertex 1 is the first in the result
      assert Enum.at(result, 0) == 1
    end

    test "DFS traversal from a non-existent vertex", %{graph: graph} do
      # Perform DFS starting from a non-existent vertex (e.g., 200)
      result = ExGraphs.Algorithms.Traversal.depth_first_search(graph, 200)

      # Assert that the result is empty
      assert result == []
    end
  end
end
