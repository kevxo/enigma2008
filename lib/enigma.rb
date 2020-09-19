class Enigma
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