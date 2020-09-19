require_relative 'enigma'
require_relative 'encryption'
require_relative 'decryption'

enigma = Enigma.new
encryption = ARGV[0]
decryption = ARGV[1]
key = ARGV[2]
date = ARGV[3]
file = File.open("#{encryption}", 'r')
encryption = file.readlines

data = enigma.decrypt(encryption[0], key, date)
decrypt_file = File.open("#{decryption}", 'w')
decrypt_file.write(data[:decryption])
decrypt_file.close
puts "Created '#{decryption}' with the #{data[:key]} and date #{data[:date]}"