class Crack
  attr_reader :cipher_message, :date, :alphabet, :shifts,
  :a, :b, :c, :d
  def initialize(cipher_message, date)
    @cipher_message = cipher_message
    @date = date
    @alphabet = ('a'..'z').to_a << ' '
    @shifts = []
    @a = 0
    @b = 0
    @c = 0
    @d = 0
  end
end