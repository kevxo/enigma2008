module Shiftable
  def get_keys
    @a += @key[0..1].to_i
    @b += @key[1..2].to_i
    @c += @key[2..3].to_i
    @d += @key[3..4].to_i
  end

  def get_offsets
    squared = @date.to_i**2
    last_four = squared.to_s.split('')
    offset = last_four.last(4).join

    @a += offset[0].to_i
    @b += offset[1].to_i
    @c += offset[2].to_i
    @d += offset[3].to_i
  end

  def add_shift
    @shifts << @a
    @shifts << @b
    @shifts << @c
    @shifts << @d
  end
end