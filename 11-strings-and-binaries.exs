###########
# 1
# Write a function that returns `true` if a single-quoted string contains only
# printable ASCII characters (space through tilde).

defmodule MyString1 do
  def all_printable?(char_list) do
    printable_ascii_range = ?\s..?~
    Enum.all?(char_list, &(&1 in printable_ascii_range))
  end
end

IO.puts "StringsAndBinaries-1"
IO.puts(MyString1.all_printable?('abc?! ~') == true)
IO.puts(MyString1.all_printable?('ébc?! ~') == false)

# 2
# Write an `anagram?(word1, word2)` that returns `true` if its parameters are
# anagrams.

defmodule MyString2 do
  def anagram?(word1, word2) do
    _char_counts(word1) == _char_counts(word2)
  end

  defp _char_counts(word) do
    Enum.reduce(String.split(word, "", trim: true), %{}, fn(char, char_counts) ->
      char_counts = Map.update(char_counts, char, 1, fn(char_count) ->
        char_count + 1
      end)
    end)
  end
end

IO.puts "StringsAndBinaries-2"
IO.puts(MyString2.anagram?("elixir", "xeiilr") == true)

# 4
# (Hard) Write a function that takes a single-quoted string of the form
# `number [+-*/] number` and returns the result of the calculation. The
# individual numbers do not have leading plus or minus signs.

defmodule MyString4 do
  def calculate(char_list) do
    [a, op, b] = String.split(to_string(char_list), " ")
    {a, ""} = Float.parse(a)
    {b, ""} = Float.parse(b)
    operations = %{
      "+" => fn(a, b) -> a + b end,
      "-" => fn(a, b) -> a - b end,
      "*" => fn(a, b) -> a * b end,
      "/" => fn(a, b) -> a / b end
    }

    operations[op].(a, b)
  end
end

IO.puts "StringsAndBinaries-4"
IO.puts(MyString4.calculate('123 + 27') == 150)


###########
# 5
# Write a function that takes a list of double-quoted strings and prints
# each on a separate line, centered in a column that has the width of the
# longest string. Make sure it works with UTF characters.

defmodule MyString5 do
  def pretty_print(list) do
    column_width = _max_string_length(list)
    Enum.each(list, fn(str) ->
      offset = column_width - String.length(str)
        |> div(2)
      new_length = String.length(str) + offset
      IO.puts String.rjust(str, new_length)
    end)
  end

  defp _max_string_length(list) do
    Enum.max_by(list, &(String.length(&1)))
      |> String.length()
  end
end

IO.puts "StringsAndBinaries-5"
MyString5.pretty_print(~w{cat 𝛿og zebra elephant})


###########
# 6
# Write a function to capitalize the sentences in a string. Each sentence is
# terminated by a period and a space. Right now, the case of the characters
# in the string is random.

defmodule MyString6 do
  def capitalize_sentences(str) do
    String.split(str, ". ")
      |> Enum.map(fn(sentence) -> String.capitalize(sentence) end)
      |> Enum.join(". ")
  end
end

IO.puts "StringsAndBinaries-6"
IO.puts(MyString6.capitalize_sentences("oh. a DOG. woof. ") == "Oh. A dog. Woof. ")

# 7
# Write a function that reads and parses the file `orders.csv` and then passes
# the result to the `sales_tax` function. You'll need the library functions
# `File.open`, `IO.read(file, :line)`, and `IO.stream(file)`.

defmodule Taxes do
  def add_sales_tax(orders, tax_rates) do
    for order <- orders do
      sales_tax = tax_rates[order[:ship_to]] || 0
      total = order[:net_amount] * (1 + sales_tax)
      order ++ [total_amount: Float.round(total, 2)]
    end
  end

  def sales_tax_from_csv(filename, tax_rates) do
    orders = File.stream!(filename)
      |> Enum.slice(1..-1)
      |> Enum.map(fn(line) ->
        [str_id, str_ship_to, str_net_amount] = String.rstrip(line)
          |> String.split(", ")

        {id, ""} = Integer.parse(str_id)
        ship_to = String.slice(str_ship_to, 1..-1)
          |> String.to_atom()
        {net_amount, ""} = Float.parse(str_net_amount)

        [
          id: id,
          ship_to: ship_to,
          net_amount: net_amount
        ]
      end)

      File.close(filename)

      add_sales_tax(orders, tax_rates)
  end
end

IO.puts "StringsAndBinaries-7"

tax_rates = [ NC: 0.075, TX: 0.08 ]
IO.inspect Taxes.sales_tax_from_csv("orders.csv", tax_rates)
