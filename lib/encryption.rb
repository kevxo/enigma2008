require_relative 'shiftable'

class Encryption
  include Shiftable
  attr_reader :message, :key, :date, :alphabet, :shifts,
              :a, :b, :c, :d, :special_characters

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
    @special_characters = ''
  end

  def letter_array
    array = []
    @message.downcase.split('').each do |letter|
      if @alphabet.include?(letter)
        array << letter
      else
        @special_characters << letter
      end
    end
    array
  end

  def letter_index
    array = []
    letter_array.each do |letter|
      if @alphabet.include?(letter)
        array << @alphabet.index(letter)
      end
    end
    array
  end

  def new_shifts_array
    @shifts << @shifts.dup if @shifts.length != letter_index.length
    @shifts.flatten.shift(@message.length)
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
    new_string += @special_characters.slice(1) if @special_characters.length > 0
    new_string
  end
end
