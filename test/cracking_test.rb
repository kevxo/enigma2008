require_relative 'test_helper'
require './lib/cracking'

class CrackTest < Minitest::Test
  def test_it_exists
    crack = Crack.new('vjqtbeaweqihssi', '291018')

    assert_instance_of Crack, crack
  end

  def test_it_has_attributes
    crack = Crack.new('vjqtbeaweqihssi', '291018')

    assert_equal 'vjqtbeaweqihssi', crack.cipher_message
    assert_equal '291018', crack.date
    assert_equal 27, crack.alphabet.count
    assert_equal [], crack.shifts
    assert_equal 0, crack.a
    assert_equal 0, crack.b
    assert_equal 0, crack.c
    assert_equal 0, crack.d
  end

  def test_it_returns_last_four_letters_of_cipher_index
    crack = Crack.new('vjqtbeaweqihssi', '291018')

    assert_equal [7, 18, 18, 8], crack.letter_index_of_cipher
  end

  def test_it_returns_array_of_index_values_from_given
    crack = Crack.new('vjqtbeaweqihssi', '291018')

    assert_equal [26, 4, 13, 3], crack.given_letter_indexes
  end
end
