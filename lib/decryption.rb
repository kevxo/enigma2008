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
end