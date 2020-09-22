require_relative 'shiftable'

class Encryption
  include Shiftable
  attr_reader :message, :key, :date, :alphabet, :shifts

  def initialize(message, key, date)
    @message = message
    @key = key
    @date = date
    @alphabet = ('a'..'z').to_a << ' '
    @shifts = get_offsets
  end

  def calculate(message, letter, index)
    letter_index = @alphabet.index(letter)
    key = @shifts[index % 4]
    message += @alphabet[(letter_index + key) % 27]
    return message, index + 1
  end

  def encode
    message = ''
    index = 0
    @message.downcase.each_char do |letter|
      if @alphabet.include?(letter)
        message, index = calculate(message, letter, index)
      else
        message += letter
      end
    end
    message
  end
end
