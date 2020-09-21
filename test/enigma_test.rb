require_relative 'test_helper'
require './lib/encryption'
require './lib/enigma'
require 'date'

class EnigmaTest < Minitest::Test
  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
  end

  def test_it_encrypts_with_date_and_key
    enigma = Enigma.new
    expected = {
      encryption: 'keder ohulw',
      key: '02715',
      date: '040895'
    }

    assert_equal expected, enigma.encrypt('hello world', '02715', '040895')
  end

  def test_it_generate_date
    enigma = Enigma.new
    Date.stubs(:today).returns(Date.new(2020, 9, 19))
    assert_equal '190920', enigma.generate_date
  end

  def test_it_generates_keys
    enigma = Enigma.new
    enigma.stubs(:rand).returns(7018)

    assert_equal '07018', enigma.generate_key
  end

  def test_it_encrypts_with_todays_date
    enigma = Enigma.new
    Date.stubs(:today).returns(Date.new(2020, 9, 19))
    expected = {
      encryption: 'pib wdmczpu',
      key: '02715',
      date: '190920'
    }

    assert_equal expected, enigma.encrypt('hello world', '02715')
  end

  def test_encrypts_with_todays_date_and_new_key
    enigma = Enigma.new
    enigma.stubs(:rand).returns(7018)
    Date.stubs(:today).returns(Date.new(2020, 9, 19))
    expected = {
      encryption: 'uymcatxfdee',
      key: '07018',
      date: '190920'
    }

    assert_equal expected, enigma.encrypt('hello world')
  end

  def test_decrypts_with_key_and_date
    enigma = Enigma.new
    expected = {
      decryption: 'hello world',
      key: '02715',
      date: '040895'
    }

    assert_equal expected, enigma.decrypt('keder ohulw', '02715', '040895')
  end

  def test_it_decrpyts_with_todays_date
    enigma = Enigma.new
    encrypted = enigma.encrypt('hello world', '02715')
    Date.stubs(:today).returns(Date.new(2020, 9, 19))
    expected = {
      decryption: 'hello world',
      key: '02715',
      date: '190920'
    }

    assert_equal expected, enigma.decrypt(encrypted[:encryption], '02715')
  end

  def test_it_returns_hash_when_cracked_with_date
    enigma = Enigma.new
    expected = {
      decryption: 'hello world end',
      date: '291018',
      key: '08234'
    }

    assert_equal expected, enigma.crack('vjqtbeaweqihssi', '291018')
  end
end
