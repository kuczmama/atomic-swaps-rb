require 'securerandom'
require 'digest'

# https://en.wikipedia.org/wiki/Lamport_signature
# 
#
# To create the private key Alice uses the random number generator to
# produce 256 pairs of random numbers (2×256 numbers in total),
#  each number being 256 bits in size, that is,
# a total of 2×256×256 bits = 128 Kibit in total.
#
# This is her private key and she will store it away in a secure place for later use.

# To create the public key she hashes each of the 512 random numbers in the private key,
# thus creating 512 hashes, each 256 bits in size.
# (Also 128 Kbits in total.) These 512 numbers form her public key, which she will share with the world.

def make_key_pair
    private_key_pairs = []
    public_key_pairs = []
    256.times do
        # Generate 2 random 256 bit numbers
        priv_1 = SecureRandom.hex(32)
        priv_2 = SecureRandom.hex(32)

        ## Generate a 256 bit hash of the random numbers
        pub_1 = Digest::SHA256.hexdigest(priv_1)
        pub_2 = Digest::SHA256.hexdigest(priv_2)
        private_key_pairs.push([priv_1, priv_2])
        public_key_pairs.push([pub_1, pub_2])
    end    
    {priv_key: private_key_pairs, pub_key: public_key_pairs}
end

##
# Signing the message
# Later Alice wants to sign a message. 
# First she hashes the message to a 256-bit hash sum. Then, for each bit in the hash, 
# based on the value of the bit, she picks one number from the corresponding pairs of 
# numbers that make up her private key (i.e., if the bit is 0, the first number is chosen, 
# and if the bit is 1, the second is chosen). This produces a sequence of 256 numbers. As each number 
# is itself 256 bits long the total size of her signature will be 256×256 bits = 65536 bits = 64 Kibit. 
# These (originally randomly picked) numbers are her signature and she publishes them along with the message.

# Note that now that Alice's private key is used, it should never be used again.
# She must destroy the other 256 numbers that she did not use for the signature.
# Otherwise, each additional signature reusing the private key reduces the security
# level against adversaries that might later create false signatures from them.[2]

def sign(msg, priv_key)
    puts "Signing msg: #{msg}"
    msg_digest = Digest::SHA256.hexdigest(msg)
    digest_binary = num_to_binary(msg_digest)
    signature = []
    # Split to get the number of bits
    digest_binary.split('').each_with_index do |bit, i|
        signature.push(priv_key[i][bit.to_i])
    end
    puts "digest_binary: #{digest_binary}"
    signature
end


# Verifying the signature
# Then Bob wants to verify Alice's signature of the message. 
# He also hashes the message to get a 256-bit hash sum. 
# Then he uses the bits in the hash sum to pick out 256 of the hashes in Alice's public key.
# He picks the hashes in the same manner that Alice picked the random numbers for the signature. 
# That is, if the first bit of the message hash is a 0, he picks the first hash in the first pair, and so on.

# Then Bob hashes each of the 256 random numbers in Alice's signature. This gives him 256 hashes. 
# If these 256 hashes exactly match the 256 hashes he just picked from Alice's public key then the signature is ok. 
# If not, then the signature is wrong.

#Note that prior to Alice publishing the signature of the message, 
# no one else knows the 2×256 random numbers in the private key. Thus, no one else can create the proper 
# list of 256 random numbers for the signature. And after Alice has published the signature, 
# others still do not know the other 256 random numbers and thus can not create signatures that fit other message hashes.
def verify(msg, signature, pub_key)
    msg_digest = Digest::SHA256.hexdigest(msg)
    digest_binary = num_to_binary(msg_digest)

    digest_binary.split('').each_with_index do |bit, i|
        pub_hash = pub_key[i][bit.to_i]
        sig_hash = Digest::SHA256.hexdigest(signature[i])
        if pub_hash != sig_hash
            return false
        end
    end

    return true
end

def num_to_binary(num)
    num.hex.to_s(2).rjust(num.size*4, '0')
end


key_pairs = make_key_pair
pub_key = key_pairs[:pub_key]
priv_key = key_pairs[:priv_key]
msg = "Send 1000 dollars to mark"

signature = sign(msg, priv_key)
puts "Is the signature valid? #{verify("Send 100 dollars to mark", signature, pub_key)}"

