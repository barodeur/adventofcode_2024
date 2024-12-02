require_relative "lib/read_lines"
require_relative "lib/report_safety"

puts ReadLines.read($stdin)
  .count(&ReportSafety.method(:safe?))
