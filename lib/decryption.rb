require_relative 'shiftable'

class Decryption
  include Shiftable
  attr_reader :cipher_text, :key, :date, :alphabet, :shifts
  def initialize(cipher_text, key, date)
    @cipher_text = cipher_text
    @key = key
    @date = date
    @alphabet = ('a'..'z').to_a << ' '
    @shifts = get_offsets
  end

  def calculate(message, letter, index)
    letter_index = @alphabet.index(letter)
    key = @shifts[index % 4]
    message += @alphabet[(letter_index - key) % 27]
    return message, index + 1
  end

  def decode
    message = ''
    index = 0
    @cipher_text.downcase.each_char do |letter|
      if @alphabet.include?(letter)
        message, index = calculate(message, letter, index)
      else
        message += letter
      end
    end
    message
  end
end
