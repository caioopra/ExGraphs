defmodule ExGraphsTest.UtilsTest do
  use ExUnit.Case

  alias ExGraphs.{Vertex, Graph, Utils}

  describe "read_graph/1" do
    test "successfully reads a graph from a .net file" do
      # Path to the test file
      file_path = "assets/test.net"

      # Read the graph
      {:ok, graph} = Utils.read_graph(file_path)

      # Test graph structure
      assert %Graph{} = graph

      # Test vertices
      assert Graph.vertices_amount(graph) == 8

      # Check first and last vertices for the example
      vertex_1 = Graph.get_vertex(graph, 1)
      assert vertex_1.label == "A"

      vertex_8 = Graph.get_vertex(graph, 8)
      assert vertex_8.label == "H"

      # Test edges
      assert Graph.edges_amount(graph) == 10

      # Check specific edges
      assert Graph.has_edge?(graph, 1, 2)
      assert Graph.has_edge?(graph, 3, 4)
      assert Graph.has_edge?(graph, 7, 6)

      # Check non-existent edges
      refute Graph.has_edge?(graph, 1, 5)
      refute Graph.has_edge?(graph, 1, 8)
    end

    test "returns error when file does not exist" do
      file_path = "assets/non_existent_file.net"
      result = Utils.read_graph(file_path)

      assert {:error, :enoent} = result
    end
  end
end
