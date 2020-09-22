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
    assert_equal [3, 27, 73, 20], encryption.shifts
  end

  def test_it_calculates
    encryption = Encryption.new('hello world', '02715', '040895')
    assert_equal ['k', 1], encryption.calculate('', 'h', 0)
  end

  def test_it_encodes
    encryption = Encryption.new("hello world\n", '02715', '040895')

    expected = "keder ohulw\n"
    assert_equal expected, encryption.encode
  end

  def test_with_capitalize
    encryption = Encryption.new('HELLO WORLD', '02715', '040895')

    expected = 'keder ohulw'
    assert_equal expected, encryption.encode
  end

  def test_with_special_characters
    encryption = Encryption.new('HELLO WORLD!', '02715', '040895')

    expected = 'keder ohulw!'
    assert_equal expected, encryption.encode
  end
end
