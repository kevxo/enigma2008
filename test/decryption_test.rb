require_relative 'test_helper'
require './lib/encryption'
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
end
