require_relative 'test_helper'
require './lib/encryption'
require './lib/decryption'

class DecryptionTest < Minitest::Test
  def test_it_exists
    decryption = Decryption.new('keder ohulw', '02715', '040895')

    assert_instance_of Decryption, decryption
  end
end
