require 'date'

class Enigma
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

  def encrypt(message, key = nil, date = nil)
    hash = {}
    @encryption = Encryption.new(message, key, date)
    @encryption.get_keys
    @encryption.get_offsets
    @encryption.add_shift
    @encryption.letter_index
    @encryption.new_shifts_array
    @encryption.encode
    hash[:encryption] = @encryption.translation
    hash[:key] = key
    hash[:date] = date
    hash
  end
end