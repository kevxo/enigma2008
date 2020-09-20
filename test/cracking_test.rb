require_relative 'test_helper'
require './lib/cracking'
require './lib/encryption'
require './lib/decryption'

class CrackTest < Minitest::Test
  def test_it_exists
    crack = Crack.new('vjqtbeaweqihssi', '291018')

    assert_instance_of Crack, crack
  end
end
