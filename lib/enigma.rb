require 'date'

class Enigma
  attr_reader :crypted, :decrypted
  def initialize
    @crypted = {}
    @decrypted = {}
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
    encryption.get_keys
    encryption.get_offsets
    encryption.add_shift
    encryption.letter_index
    encryption.new_shifts_array
    encryption.encode
    @crypted[:encryption] = encryption.translation
    @crypted[:key] = key
    @crypted[:date] = date
    @crypted
  end

  def decrypt(cypher_text, key, date = generate_date)
    decryption = Decryption.new(cypher_text, key, date)
    decryption.get_keys
    decryption.get_offsets
    decryption.add_shift
    decryption.cipher_letter_index
    decryption.new_shifts_array
    decryption.decode
    @decrypted[:decryption] = decryption.translate_cipher
    @decrypted[:key] = key
    @decrypted[:date] = date
    @decrypted
  end
end