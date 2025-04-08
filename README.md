# ExGraphs

ExGraphs is an Elixir library for creating, manipulating, and analyzing graphs. It provides a simple and intuitive API for working with graph data structures.

## Features

- **Graph Creation**: Create graphs with vertices and edges
- **File I/O**: Import graphs from standard `.net` files
- **Graph Operations**: Add vertices, create edges, check connectivity
- **Basic Queries**: Check vertex/edge existence, count vertices/edges

## Installation

Add `ex_graphs` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_graphs, "~> 0.1.0"}
  ]
end
```

## Usage

### Creating a Graph

```elixir
alias ExGraphs.Graph

# Create an empty graph
graph = %Graph{}

# Add vertices
{:ok, graph} = Graph.create_vertex(graph, 1, "A")
{:ok, graph} = Graph.create_vertex(graph, 2, "B")
{:ok, graph} = Graph.create_vertex(graph, 3, "C")

# Create edges between vertices
{:ok, graph, _, _} = Graph.create_edge(graph, 1, 2)
{:ok, graph, _, _} = Graph.create_edge(graph, 2, 3, 2.5) # with weight
```

### Reading a Graph from File

ExGraphs supports reading graphs from `.net` files:

```elixir
alias ExGraphs.Utils

# Read from a .net file
{:ok, graph} = Utils.read_graph("path/to/file.net")
```

The `.net` file should have the following format:

```
*vertices 3
1 A
2 B
3 C
*edges
1 2 1.0
2 3 2.5
```

### Graph Operations

```elixir
# Check if a vertex exists
Graph.vertex_in_graph?(graph, 1) # => true

# Get vertex info
vertex = Graph.get_vertex(graph, 1)

# Check if an edge exists
Graph.has_edge?(graph, 1, 2) # => true

# Count vertices and edges
Graph.vertices_amount(graph) # => 3
Graph.edges_amount(graph) # => 2
```

## Graph Structure

Graphs in ExGraphs are composed of:

- **Vertices**: Each vertex has an index, label, neighbors list, and degree
- **Edges**: Each edge connects two vertices with an optional weight

## Development

### Running Tests

```bash
mix test
```