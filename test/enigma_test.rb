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
    today = Date.today
    new_date = today.strftime('%d/%m/%Y').delete('/')[0..5]

    expected = {
      encryption: 'pib wdmczpu',
      key: '02715',
      date: new_date
    }

    assert_equal expected, enigma.encrypt('hello world', '02715', new_date)
  end

  def test_encrypts_with_todays_date_and_new_key
    enigma = Enigma.new
    today = Date.today
    new_date = today.strftime('%d/%m/%Y').delete('/')[0..5]
    keys = [0]
    key = (1..9).to_a.rotate.shift(4)
    keys << key
    generatred_keys = keys.flatten.join

    expected = {
      encryption: 'pescw cfzlk',
      key: generatred_keys,
      date: new_date
    }

    assert_equal expected, enigma.encrypt('hello world', generatred_keys, new_date)
  end
end
