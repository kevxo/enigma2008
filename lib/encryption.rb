require_relative 'shiftable'

class Encryption
  include Shiftable
  attr_reader :message, :key, :date, :alphabet, :shifts,
              :a, :b, :c, :d

  def initialize(message, key, date)
    @message = message
    @key = key
    @date = date
    @alphabet = ('a'..'z').to_a << ' '
    @shifts = []
    @a = 0
    @b = 0
    @c = 0
    @d = 0
  end

  def letter_index
    @message.downcase.split(//).map do |letter|
      if @alphabet.include?(letter)
        @alphabet.index(letter)
      end
    end
  end

  def new_shifts_array
    @shifts << @shifts.dup if @shifts.length != letter_index.length
    @shifts.flatten
  end

  def encode
    array = []
    new_shifts_array.each_with_index do |key, indx1|
      letter_index.each_with_index do|num, indx2|
        if indx1 == indx2
          array << (key + num) % 27
        end
      end
    end
    array
  end

  def translation
    new_string = ''
    translation = encode.map do |indx|
      @alphabet[indx]
    end.join
    new_string += translation
    new_string
  end
end
