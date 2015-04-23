#####
# 1
# Write functions to pass the tests below.

list_concat = fn
  a, b -> a ++ b
end

sum = fn
  a, b, c -> a + b + c
end

pair_tuple_to_list = fn
  {a, b} -> [a, b]
end

IO.puts "Functions-1"
IO.puts(list_concat.([:a, :b], [:c, :d]) == [:a, :b, :c, :d])
IO.puts(sum.(1, 2, 3) == 6)
IO.puts(pair_tuple_to_list.({1234, 5678}) == [1234, 5678])


#####
# 2
# Write a function that takes three arguments. If the first two are zero,
# return "FizzBuzz." If the first is zero, return "Fizz." If the second is zero,
# return "Buzz." Otherwise return the third argument. Do not use any language
# features that we haven't yet covered in this book.

print_fizzbuzz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, n -> n
end


# 3
# The operator `rem(a, b)` returns the remainder after dividing `a` by `b`. Write a
# function that takes a single integer `n` and calls the function in the previous
# exercise, passing it `rem(n, 3)`, `rem(n, 5)` and `n`. Call it seven times with
# the arguments 10, 11, 12, and so on. You should get "Buzz, 11, Fizz, 13,
# 14, FizzBuzz, 16."
#
# (Yes, it's a FizzBuzz solution with no conditional logic.)

fizzbuzz = fn
  n -> print_fizzbuzz.(rem(n, 3), rem(n, 5), n)
end

IO.puts "Functions-2 and 3"
IO.puts(fizzbuzz.(10) == "Buzz")
IO.puts(fizzbuzz.(11) == 11)
IO.puts(fizzbuzz.(12) == "Fizz")
IO.puts(fizzbuzz.(13) == 13)
IO.puts(fizzbuzz.(14) == 14)
IO.puts(fizzbuzz.(15) == "FizzBuzz")
IO.puts(fizzbuzz.(16) == 16)


#####
# 4
# Write a function `prefix` that takes a string. It should return a new function
# that takes a second string. When that second function is called, it will
# return a string containing the first string, a space, and the second string.

prefix = fn
  first -> fn
    second -> "#{first} #{second}"
  end
end

IO.puts "Functions-4"
mrs = prefix.("Mrs")
IO.puts(mrs.("Smith") == "Mrs Smith")
IO.puts(prefix.("Elixir").("Rocks") == "Elixir Rocks")


#####
# 5
# Use the `&...` notation to rewrite the following.
# - `Enum.map [1, 2, 3, 4], fn x -> x + 2 end`
# - `Enum.each [1, 2, 3, 4], fn x -> IO.inspect x end`

IO.puts "Functions-5"
plus_two = Enum.map [1, 2, 3, 4], &(&1 + 2)
IO.puts(plus_two == [3, 4, 5, 6])

Enum.each [1, 2, 3, 4], &(IO.inspect &1) # should print each number
