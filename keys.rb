# Generate a public and private keys

# secp256k1 =  y^2 = x^3 + 7
# P = 2^256 - 2^32 - 2^9 - 2^8 - 2^7 - 2^6 - 2^4 - 1

# y**2 = x**3 + 7
# y = Math.sqrt(x**3 + 7)
#
# https://github.com/bitcoinbook/bitcoinbook/blob/develop/ch04.asciidoc#elliptic_curve
#
# A private key is just a scalar number, it's 32 bytes or 256 bits of random ones and zeros
# Wherea's a public key is just the secret_key * G = public key, where G is a generator
# point, then the public key is hashed
#
#
# secret_key * generator_function = public_key ==> hash(public_key) == bitcoin_address
#
# Since G is a point on a curve, it is represented by
#
# G = (X,Y)
# Prefix:
#    - 04 - whole uncompressed key
#    - 03 - Y coordinate is positve
#    - 02 - Y coordinate is negative
# X = 04 79BE667E F9DCBBAC 55A06295 CE870B07 029BFCDB 2DCE28D9 59F2815B 16F81798
# Y = 483ADA77 26A3C465 5DA4FBFC 0E1108A8 FD17B448 A6855419 9C47D08F FB10D4B8
#
# Since the elliptic curve is symmetric, we don't actually need to store the whole value of G
# We can actually only store the X value with a prefix that says if the value of Y is positive or negative

points = []
(-10..10).each do |x|
    y = Math.sqrt(x**3 + 7)
    points.push([x, y])
    points.push([x, -y])
end

points.each do |x, y|
    puts "#{x},#{y}"
end


# P = 2**256 - 2**32 - 2**9 - 2**8 - 2**7 - 2**6 - 2**4 - 1