require "digest"
require_relative 'script'

# Convert a number to little endian
# 
# @param - num to convert to little endian
# @param - length in bytes of the resulting string
# https://stackoverflow.com/a/16078424
def to_little_endian(str, max_length)
    throw "str cannot be nil" if str.nil?
    max_length = str.length if max_length
    should_reverse = true
    if str.is_a? Integer
        str = str.to_s(16)
        should_reverse = false
    end
    str = str.ljust(max_length * 2, '0').scan(/.{2}/).map(&:reverse).join
    should_reverse ? str.reverse : str
end

# Calculate the OP_HASH160 of the input string
def hash160(hex)
  bytes = [hex].pack("H*")
  Digest::RMD160.hexdigest Digest::SHA256.digest(bytes)
end

def OP_SHA256(input)
  Digest::SHA256.digest(input)
end


# Create an m of n multisig address
#
# @param - n - the number of addresses needed for the multisig address
# @param - pub_keys - the number of pub keys needed for the address
#
# https://bitcoin.stackexchange.com/questions/3712/how-can-i-create-a-multi-signature-2-of-3-transaction
def create_multisig(m, pub_keys)
  # OP_m <bytes-in-Pubkey1> <pubKey1> ... OP_n OP_CHECKMULTISIG
  redeem_script = ""
  redeem_script += "#{num_to_opcode(m)}"
  pub_keys.each do |pub_key|

  end
end