require 'date'

class Enigma
  attr_reader :crypted
  def initialize
    @crypted = {}
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
end