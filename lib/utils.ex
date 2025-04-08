defmodule ExGraphs.Utils do
  @moduledoc """
  A module containing utility functions for graph manipulation.
  """
  alias ExGraphs.Graph

  @doc """
  Reads a graph from the given file path and returns it as a Graph struct.
  The `.net` file should contain a list of vertices and edges in the format:

  ```
  *vertices amount_of_vertices
  id label
  id label
  ...
  *edges                      # 'edges' may be 'arcs'
  u_index v_index weight
  u_index v_index weight
  ...
  ```

  ## Examples

      iex> ExGraphs.Utils.read_graph(%{vertices: %{1 => :a, 2 => :b}})
      2

      iex> ExGraphs.Utils.read_graph(%{vertices: %{}})
      0
  """
  def read_graph(path) when is_binary(path) do
    case File.read(path) do
      {:ok, content} ->
        parse_content(content)

      {:error, reason} ->
        IO.puts("Error reading file: #{reason}")
        {:error, reason}
    end
  end

  defp parse_content(content) do
    lines =
      content
      |> String.split("\n")
      |> Enum.reject(&(&1 == ""))

    vertices_amount = get_amount_of_vertices(lines)

    # removes the line with the amount of vertices information
    lines = Enum.drop(lines, 1)

    {vertices_lines, edges_information} = Enum.split(lines, vertices_amount)
    # removes the line with the edges information
    edges_lines = Enum.drop(edges_information, 1)
  end

  defp get_amount_of_vertices(lines) do
    lines
    |> Enum.at(0)
    |> String.split(" ")
    |> Enum.at(1)
    |> String.to_integer()
  end
end
