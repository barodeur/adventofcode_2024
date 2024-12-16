require_relative "lib/equation"

puts Equation.each_from_io($stdin).filter_map(&:cost).sum
