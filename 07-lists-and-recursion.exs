#######
# 0
# I defined our `sum` function to carry a partial total as a second parameter
# so I could illustrate how to use accumulators to build values. The `sum`
# function can also be written without an accumulator. Can you do it?
#
# 1
# Write a `mapsum` function that takes a list and a function. It applies the
# function to each element of the list and then sums the result, so
#
# ```
# iex> MyList.mapsum [1, 2, 3], &(&1 * &1)
# 14
# ```
#
# 2
# Write a `max(list)` that returns the element with the maximum value in the
# list. (This is slightly trickier than it sounds.)
#
# 3
# An Elixir single-quoted string is actually a list of individual character
# codes. Write a `caesar(list, n) function that adds `n` to each list element,
# wrapping if the addition results in a character greater than "z".
#
# ```
# iex> MyList.caesar('ryvkve', 13)
# ?????? :)
# ```
#
# 4
# Write a function `MyList.span(from, to)` that returns a list of the numbers from
# `from` up to `to`.

defmodule MyList do
  def caesar([], n) do
    []
  end

  def caesar([head | tail], n) do
    [ _encrypt_char(head + n) | caesar(tail, n) ]
  end

  defp _encrypt_char(code) when code > ?z do
    # wrap around
    length_of_alphabet = 26
    position_in_alphabet = code - ?a
      |> rem(length_of_alphabet)
    position_in_alphabet + ?a
  end

  defp _encrypt_char(code) do
    code
  end

  def mapsum([], _) do
    0
  end

  def mapsum([head | tail], fun) do
    fun.(head) + mapsum(tail, fun)
  end

  def max(list) do
    _max(list, nil)
  end

  defp _max([], current_max) do
    current_max
  end

  defp _max([head | tail], current_max) when is_nil(current_max) do
    _max(tail, head)
  end

  defp _max([head | tail], current_max) when head >= current_max do
    _max(tail, head)
  end

  defp _max([head | tail], current_max) when head < current_max do
    _max(tail, current_max)
  end

  def span(from, to) when from == to do
    [from]
  end

  def span(from, to) when from < to do
    [ from | span(from + 1, to) ]
  end

  def sum([]) do
    0
  end

  def sum([head | tail]) do
    head + sum(tail)
  end
end

IO.puts "ListsAndRecursion-0"
IO.puts(MyList.sum([1, 2, 3, 4]) == 10)

IO.puts "ListsAndRecursion-1"
IO.puts(MyList.mapsum([1, 2, 3], &(&1 * &1)) == 14)

IO.puts "ListsAndRecursion-2"
IO.puts(MyList.max([1, 0, 7, -1, 2]) == 7)

IO.puts "ListsAndRecursion-3"
IO.puts(MyList.caesar('abcde', 1) == 'bcdef')
IO.puts(MyList.caesar('xyz', 3) == 'abc')
IO.puts(MyList.caesar('ryvkve', 13) == 'elixir')

IO.puts "ListsAndRecursion-4"
IO.puts(MyList.span(0, 3) == [0, 1, 2, 3])
