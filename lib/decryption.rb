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
    @cipher_text.split(//).map do |letter|
      @alphabet.index(letter)
    end
  end

  def new_shifts_array
    @shifts << @shifts.dup if @shifts.length != cipher_letter_index.length
    @shifts.flatten
  end
end