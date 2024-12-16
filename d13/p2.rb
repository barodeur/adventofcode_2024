require_relative "lib/equation"

puts Equation
  .each_from_io($stdin)
  .map { |eq|
    Equation.new(
      eq.a,
      eq.b,
      eq.p.transform_values { _1 + 10_000_000_000_000 }
    )
  }
  .filter_map(&:cost)
  .sum
