require_relative 'enigma'
require_relative 'encryption'

enigma = Enigma.new
message = ARGV[0]
encryption = ARGV[1]
file = File.open("#{message}", 'r')
message = file.readlines

data = enigma.encrypt(message[0])
encrypt_file = File.open("#{encryption}", 'w')
encrypt_file.write(data[:encryption])
encrypt_file.close
puts "Created '#{encryption}' with the #{data[:key]} and date #{data[:date]}"