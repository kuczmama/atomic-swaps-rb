require 'securerandom'

# A private key is a 256 bit scalar
priv_key = SecureRandom.hex(32)

# public key = priv_key * G
# where G is a random point
# which has a 32 byte x coordinate and 32 byte y coordinate
# Since the elliptic curve is symmetric around the x axis, you only need one byte for y
# So it would be 33 bytes for the public key

# schnor is better than ecdsa

# an ecdsa curve is called secp256k1 y^2=x^3 + 7
# What if I want to add two points on the curve
# P + Q = R
#
# To add two points:
#
# Consider the case of the curve 𝑦²=𝑥³+𝑎𝑥+𝑏 on ℝ for starters. 
# Let 𝑃=(x₁,y₁) and 𝑄=(x₂,y₂) be different points on the curve. 
# You can check that if s=(y₂−y₁)/(x₂−x₁), then x₃=s²−x₁−x₂
# and y₃=y₁+s(x₃−x₁) then (x₃,y₃) is on the curve and (x₃,-y₃) is collinear with 𝑃 and 𝑄. 
# A computer algebra system like maxima is helpful here.

# Adding a point to itself involves a tangent to the curve, 
#so s=(3𝑥21+𝑎)/2𝑦1 and 𝑥3=𝑠2−2𝑥1 and 𝑦3=𝑦1+𝑠(𝑥3−𝑥1).

# The same formulas are valid on any field, as long as its characteristic isn't 2 or 3.

slope = (3 * x1 ** 2 + a) / (2 * y1)
x3 = (slope ** 2 - x1 - x2) % P
y3 = (slope * (x1 - x3) - y1) % P

