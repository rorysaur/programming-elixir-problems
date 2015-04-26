##########
# 5
# Implement the following `Enum` functions using no library functions or list
# comprehensions: `all?`, `each`, `filter`, `split`, and `take`.

defmodule MyEnum do
  def all?([], func) do
    true
  end

  def all?([head | tail], func) do
    if func.(head) do
      all?(tail, func)
    else
      false
    end
  end
  
  def each([], func) do
    nil
  end

  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end

  def filter([], func) do
    []
  end

  def filter([head | tail], func) do
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end

  def split(list, num) do
    _split([], list, num)
  end

  defp _split(taken, remaining, 0) do
    { taken, remaining }
  end

  defp _split(taken, [remaining_head | remaining_tail], num) do
    _split(taken ++ [remaining_head], remaining_tail, num - 1)
  end

  def take(list, 0) do
    []
  end

  def take([head | tail], num) do
    [head | take(tail, num - 1)]
  end
end

IO.puts "ListsAndRecursion-5"
IO.puts(MyEnum.all?([1, 2, 3], &(&1 < 4)) == true)
IO.puts(MyEnum.all?([1, 2, 5], &(&1 < 4)) == false)
MyEnum.each([1, 2, 3], &(IO.puts &1))
IO.puts(MyEnum.filter([1, 5, 2], &(&1 < 4)) == [1, 2])
IO.puts(MyEnum.take([1, 2, 3, 4, 5], 3) == [1, 2, 3])
IO.puts(MyEnum.split([1, 2, 3, 4, 5], 3) == { [1, 2, 3], [4, 5] })

# 6
# (Hard) Write a `flatten(list)` function that takes a list that may contain any
# number of sublists, which themselves may contain sublists, to any depth.
# It returns the elements of these lists as a flat list.

defmodule MyList do
  def flatten([]) do
    []
  end

  def flatten([head | tail]) do
    if is_list(head) do
      if _flat?(head) do
        head ++ flatten(tail)
      else
        flatten(head) ++ flatten(tail)
      end
    else
      [head | flatten(tail)]
    end
  end

  defp _flat?([]) do
    true
  end

  defp _flat?([head | tail]) do
    if is_list(head) do
      false
    else
      _flat?(tail)
    end
  end
end

IO.puts "ListsAndRecursion-6"
IO.inspect(MyList.flatten([1, [2, 3, [4]], 5, [[[6]]]]))


##########
# 7
# In the last exercise of Chapter 7, _Lists and Recursion_, you
# wrote a `span` function. Use it and list comprehensions to return a list of the
# prime numbers from 2 to `n`.

defmodule MyList2 do
  def primes_up_to(n) do
    for i <- span(2, n), prime?(i), do: i
  end

  def prime?(2), do: true

  def prime?(i) do
    nums = Enum.to_list(2..(i - 1))
    !Enum.any?(nums, &(rem(i, &1) == 0))
  end

  def span(from, to) when from == to do
    [from]
  end

  def span(from, to) when from < to do
    [from | span(from + 1, to)]
  end
end

IO.puts "ListsAndRecursion-7"
IO.puts(MyList2.primes_up_to(15) == [2, 3, 5, 7, 11, 13])


# 8
# Write a function that takes a list of tax rates and a list of orders, and returns
# a copy of the orders, but with an extra field, `total_amount`, which is the net plus
# sales tax. If a shipment is not to NC or TX, there's no tax applied.

tax_rates = [ NC: 0.075, TX: 0.08 ]

orders = [
  [ id: 123, ship_to: :NC, net_amount: 100.00 ],
  [ id: 124, ship_to: :OK, net_amount: 35.50 ],
  [ id: 125, ship_to: :TX, net_amount: 24.00 ],
  [ id: 126, ship_to: :TX, net_amount: 44.80 ],
  [ id: 127, ship_to: :NC, net_amount: 25.00 ],
  [ id: 128, ship_to: :MA, net_amount: 10.00 ],
  [ id: 129, ship_to: :CA, net_amount: 102.00 ],
  [ id: 120, ship_to: :NC, net_amount: 50.00 ]
]

defmodule Taxes do
  def add_sales_tax(orders, tax_rates) do
    for order <- orders do
      sales_tax = tax_rates[order[:ship_to]] || 0
      total = order[:net_amount] * (1 + sales_tax)
      order ++ [total_amount: Float.round(total, 2)]
    end
  end
end

IO.inspect Taxes.add_sales_tax(orders, tax_rates)
