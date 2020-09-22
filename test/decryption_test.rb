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
    assert_equal [3, 27, 73, 20], decryption.shifts
  end

  def test_it_calculates
    decryption = Decryption.new('keder ohulw', '02715', '040895')
    assert_equal ['h', 1], decryption.calculate('', 'k', 0)
  end

  def test_it_decodes
    decryption = Decryption.new("keder ohulw\n", '02715', '040895')

    expected = "hello world\n"
    assert_equal expected, decryption.decode
  end
end
