class Equation
  BUTTON_REGEX=/^Button [AB]: X\+(?<x>\d+), Y\+(?<y>\d+)$/
  PRIZE_REGEX=/^Prize: X=(?<x>\d+), Y=(?<y>\d+)/

  class << self
    def each_from_io(io)
      io
        .each_line
        .lazy
        .map(&:chomp)
        .chunk(&:empty?)
        .reject { |empty, _| empty }
        .map { |_, lines|
          [BUTTON_REGEX, BUTTON_REGEX, PRIZE_REGEX]
            .zip(lines).map { |regex, str| extract(regex, str) }
        }
        .map { |a, b, p| new(a, b, p) }
    end

    private

    def extract(regex, str)
      regex.match(str).named_captures.transform_keys(&:to_sym).transform_values(&:to_i)
    end
  end

  attr_accessor :a, :b, :p

  def initialize(a, b, p)
    @a = a
    @b = b
    @p = p
  end

  def cost
    b_count, b_rest = (a[:x] * p[:y] - a[:y] * p[:x]).divmod(b[:y] * a[:x] - b[:x] * a[:y])
    return nil if b_rest != 0 || b_count < 0
    a_count, a_rest = (p[:x] - b_count * b[:x]).divmod(a[:x])
    return nil if a_rest != 0 || a_count < 0

    a_count * 3 + b_count
  end
end
