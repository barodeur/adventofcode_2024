class Page
  class Comparator
    class << self
      def from_lines(lines)
        rules = lines
          .map { _1.split("|").map(&:to_i).map(&Page.method(:new)) }
          .each_with_object({}) { |(low, high), h| h[low] ||= Set.new; h[low].add(high) }
        new(rules)
      end
    end

    attr_reader :rules

    def initialize(rules)
      @rules = rules
    end

    def compare(a, b)
      return 0 if a == b

      if rules[a]&.include?(b)
        -1
      elsif rules[b]&.include?(a)
        1
      else
        raise "uncomparable"
      end
    end
  end
end
