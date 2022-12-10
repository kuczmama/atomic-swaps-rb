# Convert a number to little endian
# 
# @param - num to convert to little endian
# @param - length in bytes of the resulting string
# https://stackoverflow.com/a/16078424
def to_little_endian(str, max_length)
    throw "str cannot be nil" if str.nil?
    should_reverse = true
    if str.is_a? Integer
        str = str.to_s(16)
        should_reverse = false
    end
    str = str.ljust(max_length * 2, '0').scan(/.{2}/).map(&:reverse).join
    should_reverse ? str.reverse : str
end