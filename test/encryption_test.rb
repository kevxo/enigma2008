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
    assert_equal [], encryption.non_letters
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
end
