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

  def test_it_returns_array_possible_keys
    crack = Crack.new('vjqtbeaweqihssi', '291018')

    assert_equal [-19, 14, 5, 5], crack.array_of_possible_keys
  end

  def test_it_returns_array_of_shifts
    crack = Crack.new('vjqtbeaweqihssi', '291018')

    assert_equal [14, 5, 5, 8], crack.our_shifts_used
  end

  def test_it_returns_array_of_keys
    crack = Crack.new('vjqtbeaweqihssi', '291018')

    assert_equal [6, 3, 2, 4], crack.obtain_offsets
    assert_equal [8, 2, 3, 4], crack.obtain_keys
  end

  def test_it_returns_cihper_letter_index
    crack = Crack.new('vjqtbeaweqihssi', '291018')

    expected = [21, 9, 16, 19, 1, 4, 0, 22, 4, 16, 8, 7, 18, 18, 8]
    assert_equal expected, crack.cipher_letter_index
  end

  def test_it_returns_array_shifts
    crack = Crack.new('vjqtbeaweqihssi', '291018')
    crack.cipher_letter_index

    assert_equal [14, 5, 5, 8, 14, 5, 5, 8, 14, 5, 5, 8, 14, 5, 5], crack.new_shifts_array
  end

  def test_it_decodes
    crack = Crack.new('vjqtbeaweqihssi', '291018')

    crack.cipher_letter_index
    crack.new_shifts_array

    expected = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3, 26, 4, 13, 3]
    assert_equal expected, crack.decode
  end

  def test_it_translates_cipher
    crack = Crack.new('vjqtbeaweqihssi', '291018')

    crack.cipher_letter_index
    crack.new_shifts_array
    crack.decode

    assert_equal 'hello world end', crack.translate_cipher
  end
end
