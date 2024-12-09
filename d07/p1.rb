require_relative "./lib/equation"

def possible?(equation)
  test_value = equation.test_value
  numbers = equation.numbers

  a, *rest = numbers
  return test_value == a if rest.empty?

  b, *rest = rest
  possible?(Equation.new(test_value, [a + b, *rest])) || \
    possible?(Equation.new(test_value, [a * b, *rest]))
end

puts Equation.array_from_io($stdin)
  .filter(&method(:possible?))
  .sum(&:test_value)
