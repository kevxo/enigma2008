require_relative 'shiftable'

class Decryption
  include Shiftable
  attr_reader :cipher_text, :key, :date, :alphabet, :shifts,
  :a, :b, :c, :d
  def initialize(cipher_text, key, date)
    @cipher_text = cipher_text
    @key = key
    @date = date
    @alphabet = ('a'..'z').to_a << ' '
    @shifts = []
    @a = 0
    @b = 0
    @c = 0
    @d = 0
  end

  def cipher_letter_index
    @cipher_text.downcase.split('').map do |letter|
      @alphabet.index(letter)
    end
  end

  def new_shifts_array
    @shifts << @shifts.dup if @shifts.length != cipher_letter_index.length
    @shifts.flatten.shift(@cipher_text.length)
  end

  def decode
    array = []
    new_shifts_array.each_with_index do |key, indx1|
      cipher_letter_index.each_with_index do|num, indx2|
        if indx1 == indx2
          array << (num - key) % 27
        end
      end
    end
    array
  end

  def translate_cipher
    message = ''
    translate = decode.map do |letter|
      @alphabet[letter]
    end.join
    message += translate
    message
  end
end