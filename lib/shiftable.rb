module Shiftable
  def get_keys
    keys = []
    4.times do |index|
      keys << @key[index..index + 1].to_i
    end
    keys
  end

  def get_offsets
    squared = @date.to_i**2
    last_four = squared.digits.first(4)
    keys = get_keys
    last_four.reverse.map.with_index do |num, index|
      num + keys[index]
    end
  end
end