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
  end
end
