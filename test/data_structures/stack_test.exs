defmodule StructuresTest.StackTest do
  use ExUnit.Case
  alias Structures.Stack

  describe "push/2" do
    test "pushes an item onto the stack" do
      stack = %Stack{stack: [1, 2]}
      new_stack = Stack.push(stack, 3)

      assert new_stack.stack == [3, 1, 2]
    end
  end

  describe "pop/1" do
    test "pops the top item from a non-empty stack" do
      stack = %Stack{stack: [1, 2, 3]}
      {:ok, top, new_stack} = Stack.pop(stack)

      assert top == 1
      assert new_stack.stack == [2, 3]
    end

    test "returns an error when popping from an empty stack" do
      stack = %Stack{stack: []}
      assert {:error, nil, :empty_stack} = Stack.pop(stack)
    end
  end

  describe "head/1" do
    test "returns the top item without removing it from a non-empty stack" do
      stack = %Stack{stack: [1, 2, 3]}
      {:ok, top, same_stack} = Stack.head(stack)

      assert top == 1
      assert same_stack == stack
    end

    test "returns an error when getting the head of an empty stack" do
      stack = %Stack{stack: []}
      assert {:error, nil, :empty_stack} = Stack.head(stack)
    end
  end

  describe "empty?/1" do
    test "returns true for an empty stack" do
      stack = %Stack{stack: []}
      assert Stack.empty?(stack) == true
    end

    test "returns false for a non-empty stack" do
      stack = %Stack{stack: [1, 2]}
      assert Stack.empty?(stack) == false
    end
  end

  describe "from_list/1 and to_list/1" do
    test "converts a list to a stack and back to a list" do
      list = [1, 2, 3]
      stack = Stack.from_list(list)
      assert stack.stack == list

      converted_list = Stack.to_list(stack)
      assert converted_list == list
    end
  end

  describe "size/1" do
    test "returns the size of the stack" do
      stack = %Stack{stack: [1, 2, 3]}
      assert Stack.size(stack) == 3

      empty_stack = %Stack{stack: []}
      assert Stack.size(empty_stack) == 0
    end
  end

  describe "new/0 and new/1" do
    test "creates an empty stack with new/0" do
      stack = Stack.new()
      assert stack.stack == []
    end

    test "creates a stack from a list with new/1" do
      stack = Stack.new([1, 2, 3])
      assert stack.stack == [1, 2, 3]
    end

    test "raises an error when new/1 is called with a non-list argument" do
      assert_raise ArgumentError, fn ->
        Stack.new(123)
      end
    end
  end
end
