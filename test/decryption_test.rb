require_relative 'test_helper'
require './lib/decryption'

class DecryptionTest < Minitest::Test
  def test_it_exists
    decryption = Decryption.new('keder ohulw', '02715', '040895')

    assert_instance_of Decryption, decryption
  end

  def test_attributes
    decryption = Decryption.new('keder ohulw', '02715', '040895')

    assert_equal 'keder ohulw', decryption.cipher_text
    assert_equal '02715', decryption.key
    assert_equal '040895', decryption.date
    assert_equal 27, decryption.alphabet.count
    assert_equal [], decryption.shifts
    assert_equal 0, decryption.a
    assert_equal 0, decryption.b
    assert_equal 0, decryption.c
    assert_equal 0, decryption.d
  end

  def test_it_returns_shifts
    decryption = Decryption.new('keder ohulw', '02715', '040895')

    decryption.get_keys
    assert_equal 2, decryption.a
    assert_equal 27, decryption.b
    assert_equal 71, decryption.c
    assert_equal 15, decryption.d

    decryption.get_offsets
    assert_equal 3, decryption.a
    assert_equal 27, decryption.b
    assert_equal 73, decryption.c
    assert_equal 20, decryption.d

    decryption.add_shift

    assert_equal [3, 27, 73, 20], decryption.shifts
  end

  def test_it_returns_cihper_letter_index
    decryption = Decryption.new('keder ohulw', '02715', '040895')

    expected = [10, 4, 3, 4, 17, 26, 14, 7, 20, 11, 22]
    assert_equal expected, decryption.cipher_letter_index
  end

  def test_it_returns_array_shifts
    decryption = Decryption.new('keder ohulw', '02715', '040895')
    decryption.get_keys
    decryption.get_offsets
    decryption.add_shift
    decryption.cipher_letter_index

    assert_equal [3, 27, 73, 20, 3, 27, 73, 20], decryption.new_shifts_array
  end

  def test_it_decodes
    decryption = Decryption.new('keder ohulw', '02715', '040895')

    decryption.get_keys
    decryption.get_offsets
    decryption.add_shift
    decryption.cipher_letter_index
    decryption.new_shifts_array

    expected = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]
    assert_equal expected, decryption.decode
  end

  def test_it_translates_cipher
    decryption = Decryption.new('keder ohulw', '02715', '040895')

    decryption.get_keys
    decryption.get_offsets
    decryption.add_shift
    decryption.cipher_letter_index
    decryption.new_shifts_array
    decryption.decode

    assert_equal 'hello world', decryption.translate_cipher
  end
end
