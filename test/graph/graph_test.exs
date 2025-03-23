defmodule ExGraphsTest.GraphTest do
  use ExUnit.Case

  alias ExGraphs.{Vertex, Edge, Graph}

  describe "Vertex manipulation on Graph struct tests" do
    IO.puts("Running Graph tests for vertices manipulation")

    test "insert_vertex/2 inserting new vertex successfully" do
      graph = %Graph{}

      vertex = %Vertex{index: 1, label: "A"}

      {status, graph} =
        graph
        |> Graph.insert_vertex(vertex)

      assert status == :ok
      assert graph.vertices == %{1 => vertex}
      assert graph.edges == %{}
    end

    test "insert_vertex/2 shouldn't insert duplicate vertices" do
      graph = %Graph{}

      vertex = %Vertex{index: 1, label: "A"}

      graph =
        graph
        |> Graph.insert_vertex(vertex)
        |> elem(1)

      {status, graph} =
        graph
        |> Graph.insert_vertex(vertex)

      assert status == :error
      assert graph.vertices == %{1 => vertex}
      assert graph.edges == %{}
    end
  end
end
