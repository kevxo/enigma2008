class Crack
  attr_reader :cipher_message, :date, :alphabet, :shifts,
              :a, :b, :c, :d, :offsets, :keys
  def initialize(cipher_message, date)
    @cipher_message = cipher_message
    @date = date
    @alphabet = ('a'..'z').to_a << ' '
    @shifts = []
    @offsets = []
    @keys = []
    @a = 0
    @b = 0
    @c = 0
    @d = 0
  end

  def letter_index_of_cipher
    last_four = @cipher_message.split('')
    letters = last_four.last(4)
    letters.map do |letter|
      alphabet.index(letter)
    end
  end

  def given_letter_indexes
    given = ' end'
    given_letters = given.split('')
    given_letters.map do |letter|
      alphabet.index(letter)
    end
  end

  def array_of_possible_keys
    array = []
    letter_index_of_cipher.each_with_index do |letter, index1|
      given_letter_indexes.each_with_index do |given, index2|
        if index1 == index2
          array << (letter - given)
        end
      end
    end
    array
  end

  def our_shifts_used
    array_of_possible_keys.each do |letter|
      if letter < 0
        @shifts << letter % 27
      else
        @shifts << letter
      end
    end
    @shifts.rotate
  end
end