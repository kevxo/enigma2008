require_relative 'enigma'
require_relative 'encryption'
require_relative 'decryption'
require_relative 'cracking'

enigma = Enigma.new
encryption = ARGV[0]
crack = ARGV[1]
date = ARGV[2]

file = File.open("#{encryption}", 'r')
encryption = file.readlines

data = enigma.crack(encryption[0], date)
crack_file = File.open("#{crack}", 'w')
crack_file.write(data[:decryption])
crack_file.close
puts "Created '#{crack} with the cracked key #{data[:key]} and date #{data[:date]}"


