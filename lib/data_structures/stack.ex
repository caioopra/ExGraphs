defmodule Structures.Stack do
  @moduledoc """
  A simple stack implementation of a stack using list.
  """

  @type t :: %__MODULE__{
          stack: list()
        }

  defstruct stack: []

  @doc """
  Pushes an item onto the stack.
  ## Examples

      iex> stack = %Structures.Stack{stack: [1, 2]}
      iex> new_stack = Structures.Stack.push(stack, 3)
      iex> new_stack
      %Structures.Stack{stack: [3, 1, 2]}
  """
  def push(%__MODULE__{stack: stack} = s, item) do
    %__MODULE__{s | stack: [item | stack]}
  end

  @spec pop(t()) :: {:ok, any(), t()} | {:error, nil, :empty_stack}
  @doc """
  Returns the top element of the stack and a new stack with that element removed.
  If the stack is empty, it returns an error tuple.

  ## Examples

      iex> stack = %Structures.Stack{stack: [1, 2, 3]}
      iex> {:ok, top, new_stack} = Structures.Stack.pop(stack)
      iex> top
      1

      iex> new_stack
      %Structures.Stack{stack: [2, 3]}

      iex> stack = %Structures.Stack{stack: []}
      iex> {:error, nil, :empty_stack} = Structures.Stack.pop(stack)
  """
  def pop(%__MODULE__{stack: []} = _s) do
    {:error, nil, :empty_stack}
  end

  def pop(%__MODULE__{stack: [head | tail]} = s) do
    {:ok, head, %__MODULE__{s | stack: tail}}
  end

  @spec head(t()) :: {:ok, any(), t()} | {:error, nil, :empty_stack}
  @doc """
  Returns the top/head element of the stack without removing it.
  """
  def head(%__MODULE__{stack: []} = _s) do
    {:error, nil, :empty_stack}
  end

  def head(%__MODULE__{stack: [head | _tail]} = s) do
    {:ok, head, s}
  end

  @doc """
  Checks if the stack is empty.
  ## Examples

      iex> stack = %Structures.Stack{stack: []}
      iex> Structures.Stack.empty?(stack)
      true

      iex> stack = %Structures.Stack{stack: [1, 2]}
      iex> Structures.Stack.empty?(stack)
      false
  """
  @spec empty?(t()) :: boolean()
  def empty?(%__MODULE__{stack: []}) do
    true
  end

  def empty?(%__MODULE__{stack: _}) do
    false
  end

  @spec from_list(list()) :: t()
  def from_list(list) do
    %__MODULE__{stack: list}
  end

  @spec to_list(t()) :: list()
  def to_list(%__MODULE__{stack: stack}) do
    stack
  end

  @spec size(t()) :: non_neg_integer()
  def size(%__MODULE__{stack: stack}) do
    length(stack)
  end

  @spec new() :: t()
  def new() do
    %__MODULE__{}
  end

  @spec new(list()) :: t()
  def new(list) when is_list(list) do
    %__MODULE__{stack: list}
  end

  @spec new(any()) :: no_return()
  def new(other) do
    raise ArgumentError, "Expected a list, got: #{inspect(other)}"
  end
end
