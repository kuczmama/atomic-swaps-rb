# Generate a public and private keys

# secp256k1 =  y^2 = x^3 + 7
# P = 2^256 - 2^32 - 2^9 - 2^8 - 2^7 - 2^6 - 2^4 - 1

# y**2 = x**3 + 7
# y = Math.sqrt(x**3 + 7)
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