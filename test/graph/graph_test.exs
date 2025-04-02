defmodule ExGraphsTest.GraphTest do
  use ExUnit.Case

  alias ExGraphs.{Vertex, Graph}

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

    test "create_vertex/2 creating new vertex successfully" do
      graph = %Graph{}

      {status, graph} =
        graph
        |> Graph.create_vertex(1, "Test")

      assert status == :ok
      assert ExGraphs.Graph.vertices_amount(graph) == 1
    end

    test "create_vertex/1 should create new vertex with default label equal to index" do
      graph = %Graph{}

      {status, graph} =
        graph
        |> Graph.create_vertex(1)

      assert status == :ok
      assert ExGraphs.Graph.vertices_amount(graph) == 1
      assert Map.get(graph.vertices, 1).label == "1"
    end
  end

  describe "Edge manipulation on Graph struct tests" do
    setup do
      graph = %Graph{}

      graph =
        graph
        |> Graph.create_vertex(1, "A")
        |> then(fn {:ok, g} -> g end)
        |> Graph.create_vertex(2, "B")
        |> then(fn {:ok, g} -> g end)
        |> Graph.create_vertex(3, "C")
        |> then(fn {:ok, g} -> g end)

      %{graph: graph}
    end

    test "create_edge/4 should create a new edge between existing vertices", %{graph: graph} do
      u = Graph.get_vertex(graph, 1)
      v = Graph.get_vertex(graph, 2)

      {status, graph, u, v} = Graph.create_edge(graph, u, v)

      assert status == :ok
      assert Map.has_key?(graph.edges, {1, 2})  # error here ?

      assert u.degree == 1
      assert v.degree == 1
    end

    test "create_edge/4 should fail when vertices don't exist", %{graph: graph} do
      u = Graph.get_vertex(graph, 1)
      vertex = %Vertex{index: 100, label: "Not in Graph"}

      {status, _graph, _u, _v} = Graph.create_edge(graph, u, vertex, weight: 5)

      assert status == :error
    end
  end
end
