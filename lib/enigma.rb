require 'date'
require_relative 'decryption'
require_relative 'cracking'

class Enigma
  attr_reader :crypted, :decrypted
  def initialize
    @crypted = {}
    @decrypted = {}
    @cracked = {}
  end

  def generate_date
    today = Date.today
    new_date = today.strftime('%d/%m/%Y').delete('/')[0..5]
    new_date
  end

  def generate_key
    key = rand(1000..9999)
    generate = key.to_s.insert(0, '0')
    generate
  end

  def encrypt(message, key = generate_key, date = generate_date)
    encryption = Encryption.new(message, key, date)
    @crypted[:encryption] = encryption.encode
    @crypted[:key] = key
    @crypted[:date] = date
    @crypted
  end

  def decrypt(cypher_text, key, date = generate_date)
    decryption = Decryption.new(cypher_text, key, date)
    @decrypted[:decryption] = decryption.decode
    @decrypted[:key] = key
    @decrypted[:date] = date
    @decrypted
  end

  def crack(cipher_message, date = generate_date)
    crack = Crack.new(cipher_message, date)
    @cracked[:decryption] = crack.translate_cipher
    @cracked[:date] = date
    @cracked[:key] = crack.obtain_keys.shift(4).join.to_s.insert(0, '0')
    @cracked
  end
end