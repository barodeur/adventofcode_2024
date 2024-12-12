class StonesCounter
  def initialize
    @cache = {}
  end

  def count(stones, i)
    @cache[[stones, i]] ||= _count(stones, i)
  end

  private

  def _count(stones, i)
    return stones.size if i == 0

    if stones.size == 1
      stone = stones[0]
      return count(["1"], i - 1) if stone == "0"

      if stone.size.even?
        return count([stone[0...(stone.size / 2)]], i - 1) + \
          count([stone[(stone.size / 2)...].to_i.to_s], i - 1)
      end

      return count([(stone.to_i * 2024).to_s], i - 1)
    end

    stones.sum { |stone| count([stone], i) }
  end
end
