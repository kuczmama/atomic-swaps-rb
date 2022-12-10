require_relative 'transaction'


tx1 = Transaction.new
tx1.set_version(1)
tx1.add_input('29c712cde6fe6f0f82d5b8cfad9ca07c2446f1c9d93943f01bfaf861bdb1a2fd', 2)
puts "tx1: #{tx1}"

# puts to_little_endian(1, 4)
# puts to_little_endian(2, 4)
# puts to_little_endian(4294967295, 4)
# puts to_little_endian('29c712cde6fe6f0f82d5b8cfad9ca07c2446f1c9d93943f01bfaf861bdb1a2fd', 32)