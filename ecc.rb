# Function to compute the modular inverse of a value
def mod_inverse(value, modulus)
    # Implement the extended Euclidean algorithm to find the modular inverse
    a = value
    b = modulus
    x = 0
    y = 1
    last_x = 1
    last_y = 0
    while b != 0
      quotient = a / b
      a, b = b, a % b
      x, last_x = last_x - quotient * x, x
      y, last_y = last_y - quotient * y, y
    end
  
    # Make sure the modular inverse is non-negative
    last_x %= modulus
    last_x += modulus if last_x < 0
  
    # Return the modular inverse
    last_x
end
  

# Define the elliptic curve y^2 = x^3 + ax + b
a = 0
b = 7

# Define the prime modulus
p = 2**256 - 2**32 - 2**9 - 2**8 - 2**7 - 2**6 - 2**4 - 1

# Choose a random private key in the range [1, n - 1], where n is the order of the curve
n = 115792089237316195423570985008687907852837564279074904382605163141518161494337
private_key = rand(1...n)

# Compute the corresponding public key using the formula (x, y) = k * (x1, y1),
# where (x1, y1) is the generator point of the curve and k is the private key
# We use the double and add algorithm to compute this multiplication
result = [0, 0] # this will be our running total
addend = [55066263022277343669578718895168534326250603453777594175500187360389116729240,
          32670510020758816978083085130507043184471273380659243275938904335757337482424] # this will be the point we add to the total
private_key.times do
  # Double the point (which means computing 2P)
  if addend[1] == 0
    # If the y-coordinate of the point is 0, then the point is the "point at infinity",
    # and we can't double it, so we're done.
    break
  end
  slope = (3 * addend[0] * addend[0] + a) * mod_inverse(2 * addend[1], p)
  x = (slope * slope - 2 * addend[0]) % p
  y = (slope * (addend[0] - x) - addend[1]) % p
  addend = [x, y]

  # Add the point to the total
  if result == [0, 0]
    # If the result is the "point at infinity", then we just set it to the addend
    result = addend
  else
    # Otherwise, we compute the sum of the result and the addend using the formula
    # (x1, y1) + (x2, y2) = (x1 + x2, y1 + y2)
    if addend[0] == result[0]
      # If the x-coordinates are the same, then we're either doubling the point or
      # adding the point to itself, which means the y-coordinates must be opposite
      # (i.e. y1 = -y2), in which case the result is the "point at infinity"
      result = [0, 0]
    else
      slope = (addend[1] - result[1]) * mod_inverse(addend[0] - result[0], p)
      x = (slope * slope - result[0] - addend[0]) % p
      y = (slope * (result[0] - x) - result[1]) % p
      result = [x, y]
    end
  end
end

# Print the result
puts "Private key: #{private_key}"
puts "Public key: (#{result[0]}, #{result[1]})"
