require_relative "./lib/page"
require_relative "./lib/update"

LINES_ENUMERATOR = $stdin.each_line.lazy.map(&:strip)

Page.comparator = Page::Comparator.from_lines(LINES_ENUMERATOR.take_while { !_1.empty? })

puts LINES_ENUMERATOR
  .map(&Update.method(:from_line))
  .filter(&:incorrect?)
  .map(&:sort)
  .map(&:middle_page)
  .sum(&:n)
