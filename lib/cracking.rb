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

  def obtain_offsets
    squared = @date.to_i**2
    last_four = squared.to_s.split('')
    offsets = last_four.last(4).flatten
    offsets.each do |offset|
      @offsets << offset.to_i
    end
    @offsets
  end

  def obtain_keys
    our_shifts_used.each_with_index do |shift, indx1|
      offsets.each_with_index do |offset, indx2|
        if indx1 == indx2
          @keys << shift - offset
        end
      end
    end
    @keys
  end

  def cipher_letter_index
    @cipher_message.downcase.split('').map do |letter|
      @alphabet.index(letter)
    end
  end

  def new_shifts_array
    our_shifts_used << our_shifts_used.dup if our_shifts_used.length != cipher_letter_index.length
    our_shifts_used.flatten.shift(@cipher_message.length)
  end

  def decode
    array = []
    new_shifts_array.each_with_index do |key, indx1|
      cipher_letter_index.each_with_index do |num, indx2|
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