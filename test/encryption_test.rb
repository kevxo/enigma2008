require_relative 'test_helper'
require './lib/encryption'

class EncryptionTest < Minitest::Test
  def test_it_exists
    encryption = Encryption.new('hello world', '02715', '040895')

    assert_instance_of Encryption, encryption
  end

  def test_attributes
    encryption = Encryption.new('hello world', '02715', '040895')

    assert_equal 'hello world', encryption.message
    assert_equal '02715', encryption.key
    assert_equal '040895', encryption.date
    assert_equal 27, encryption.alphabet.count
    assert_equal [], encryption.shifts
    assert_equal 0, encryption.a
    assert_equal 0, encryption.b
    assert_equal 0, encryption.c
    assert_equal 0, encryption.d
  end

  def test_it_returns_shifts
    encryption = Encryption.new('hello world', '02715', '040895')

    encryption.get_keys
    assert_equal 2, encryption.a
    assert_equal 27, encryption.b
    assert_equal 71, encryption.c
    assert_equal 15, encryption.d

    encryption.get_offsets
    assert_equal 3, encryption.a
    assert_equal 27, encryption.b
    assert_equal 73, encryption.c
    assert_equal 20, encryption.d

    encryption.add_shift

    assert_equal [3, 27, 73, 20], encryption.shifts
  end

  def test_returns_letter_index_in_alphabet
    encryption = Encryption.new('hello world', '02715', '040895')

    expected = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]
    assert_equal expected, encryption.letter_index
  end

  def test_shifts_length_matches_message_length
    encryption = Encryption.new('hello world', '02715', '040895')

    encryption.get_keys
    encryption.get_offsets
    encryption.add_shift
    encryption.letter_index

    assert_equal 8, encryption.new_shifts_array.count
  end

  def test_it_returns_array_to_encrypt
    encryption = Encryption.new('hello world', '02715', '040895')

    encryption.get_keys
    encryption.get_offsets
    encryption.add_shift
    encryption.letter_index
    encryption.new_shifts_array

    expected = [10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22]
    assert_equal expected, encryption.encode
  end

  def test_it_can_return_translation
    encryption = Encryption.new('hello world', '02715', '040895')

    encryption.get_keys
    encryption.get_offsets
    encryption.add_shift
    encryption.letter_index
    encryption.new_shifts_array
    encryption.encode

    assert_equal 'keder ohulw', encryption.translation
  end

  def test_it_works_when_message_is_capital
    encryption = Encryption.new('HELLO WORLD', '02715', '040895')

    encryption.get_keys
    encryption.get_offsets
    encryption.add_shift
    encryption.letter_index
    encryption.new_shifts_array
    encryption.encode

    assert_equal 'keder ohulw', encryption.translation
  end
end
