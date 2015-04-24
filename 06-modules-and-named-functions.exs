######
# 1
# Extend the `Times` module with a `triple` function that multiplies its parameter by three.
#
# 2
# Run the result in iex. Use both techniques to compile the file.
#
# 3
# Add a `quadruple` function. (Maybe it could call the `double` function...)

defmodule Times do
  def double(n) do
    n * 2
  end

  def triple(n) do
    n * 3
  end

  def quadruple(n) do
    double(double(n))
  end
end

IO.puts "ModulesAndFunctions-1"
IO.puts(Times.triple(5) == 15)

IO.puts "ModulesAndFunctions-3"
IO.puts(Times.quadruple(5) == 20)


######
# 4
# Implement and run a function `sum(n)` that uses recursion to calculate the
# sum of the integers from 1 to `n`.
#
# 5
# Write a function `gcd(x, y)` that finds the greatest common divisor between
# two nonnegative integers. Algebraically, `gcd(x, y)` is `x` if `y` is zero; it's
# `gcd(y, rem(x, y))` otherwise.

defmodule Recursive do
  def sum(1) do
    1
  end

  def sum(n) do
    n + sum(n - 1)
  end

  def gcd(x, 0) do
    x
  end

  def gcd(x, y) do
    gcd(y, rem(x, y))
  end
end

IO.puts "ModulesAndFunctions-4"
IO.puts(Recursive.sum(4) == 4 + 3 + 2 + 1)

IO.puts "ModulesAndFunctions-5"
IO.puts(Recursive.gcd(16, 24) == 8)
IO.puts(Recursive.gcd(3, 7) == 1)
IO.puts(Recursive.gcd(1, 0) == 1)
IO.puts(Recursive.gcd(0, 1) == 1)


######
# 6
# _I'm thinking of a number between 1 and 1000..._
#
# The most efficient way to find the number is to guess halfway between
# the low and high numbers of the range. If our guess is too big, then the
# answer lies between the bottom of the range and one less than our guess.
# If our guess is too small, then the answer lies between one more than our
# guess and the end of the range.
#
# Your API will be `guess(actual, range)`, where `range` is an Elixir range.
#
# Your output should look similar to this:
#
# ```
# iex> Chop.guess(273, 1...1000)
# Is it 500
# Is it 250
# Is it 375
# Is it 312
# Is it 281
# Is it 265
# Is it 273
# 273
#
# Hints:
# - You may need to implement helper functions with an additional
#   parameter (the currently guessed number).
# - The `div(a, b)` function performs integer division.
# - Guard clauses are your friends.
# - Patterns can match the low and high parts of a range (`a..b = 4..8`).

defmodule Chop do
  def check_guess(actual, guess) when guess > actual do
    :too_high
  end

  def check_guess(actual, guess) when guess < actual do
    :too_low
  end

  def check_guess(actual, guess) when guess == actual do
    :correct
  end

  def current_guess(min..max) do
    diff = max - min
    div(diff, 2) + min
  end

  def guess(actual, range) do
    print_or_end(actual, range, current_guess(range))
  end

  def print_actual(actual) do
    IO.puts actual
  end

  def print_or_end(actual, _, current_guess) when actual == current_guess do
    print_guess(actual)
    print_actual(actual) 
  end

  def print_or_end(actual, range, current_guess) do
    print_guess(current_guess)
    reduced_range = check_guess(actual, current_guess)
      |> reduce_range(range, current_guess)
    guess(actual, reduced_range)
  end

  def print_guess(guess) do
    IO.puts "Is it #{guess}"
  end

  def reduce_range(guess_result, min..max, current_guess) when guess_result == :too_high do
    min..(current_guess - 1)
  end

  def reduce_range(guess_result, min..max, current_guess) when guess_result == :too_low do
    (current_guess + 1)..max
  end
end


######
# 7
# Find the library functions to do the following, and then use each in iex.
# (If the word _Elixir_ or _Erlang_ appears at the end of the challenge, then you'll
# find the answer in that set of libraries.

# - Convert a float to a string with two decimal digits. (Erlang)
IO.puts(:erlang.float_to_binary(3.1415, [{:decimals, 2}]) == "3.14")

# - Get the value of an operating-system environment variable. (Elixir)
IO.puts(System.get_env("PWD"))

# - Return the extension component of a file name (so return `.exs` if given "dave/test.exs"). (Elixir)
IO.puts(Path.extname("dave/test.exs") == ".exs")

# - Return the process's current working directory. (Elixir)
IO.puts(System.cwd())

# - Convert a string containing JSON into Elixir data structures. (Just
# find; don't install.)
# => Poison.Parser.parse!(json)

# - Execute a command in your operating system's shell.
IO.inspect(System.cmd("ls", []))
