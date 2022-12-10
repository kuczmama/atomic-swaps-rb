# https://github.com/lian/bitcoin-ruby/blob/master/lib/bitcoin/script.rb
OP_0           = 0
OP_FALSE       = 0
OP_1           = 81
OP_TRUE        = 81
OP_2           = 0x52
OP_3           = 0x53
OP_4           = 0x54
OP_5           = 0x55
OP_6           = 0x56
OP_7           = 0x57
OP_8           = 0x58
OP_9           = 0x59
OP_10          = 0x5a
OP_11          = 0x5b
OP_12          = 0x5c
OP_13          = 0x5d
OP_14          = 0x5e
OP_15          = 0x5f
OP_16          = 0x60

OP_PUSHDATA0   = 0
OP_PUSHDATA1   = 76
OP_PUSHDATA2   = 77
OP_PUSHDATA4   = 78
OP_PUSHDATA_INVALID = 238 # 0xEE
OP_NOP         = 97
OP_DUP         = 118
OP_HASH160     = 169
OP_EQUAL       = 135
OP_VERIFY      = 105
OP_EQUALVERIFY = 136
OP_CHECKSIG    = 172
OP_CHECKSIGVERIFY      = 173
OP_CHECKMULTISIG       = 174
OP_CHECKMULTISIGVERIFY = 175
OP_TOALTSTACK   = 107
OP_FROMALTSTACK = 108
OP_TUCK         = 125
OP_SWAP         = 124
OP_BOOLAND      = 154
OP_ADD          = 147
OP_SUB          = 148
OP_GREATERTHANOREQUAL = 162
OP_DROP         = 117
OP_HASH256      = 170
OP_SHA256       = 168
OP_SHA1         = 167
OP_RIPEMD160    = 166
OP_NOP1         = 176
OP_NOP2         = 177
OP_NOP3         = 178
OP_NOP4         = 179
OP_NOP5         = 180
OP_NOP6         = 181
OP_NOP7         = 182
OP_NOP8         = 183
OP_NOP9         = 184
OP_NOP10        = 185
OP_CODESEPARATOR = 171
OP_MIN          = 163
OP_MAX          = 164
OP_2OVER        = 112
OP_2ROT         = 113
OP_2SWAP        = 114
OP_IFDUP        = 115
OP_DEPTH        = 116
OP_1NEGATE      = 79
OP_WITHIN         = 165
OP_NUMEQUAL       = 156
OP_NUMEQUALVERIFY = 157
OP_LESSTHAN     = 159
OP_LESSTHANOREQUAL = 161
OP_GREATERTHAN  = 160
OP_NOT            = 145
OP_0NOTEQUAL = 146
OP_ABS = 144
OP_1ADD = 139
OP_1SUB = 140
OP_NEGATE = 143
OP_BOOLOR = 155
OP_NUMNOTEQUAL = 158
OP_RETURN = 106
OP_OVER = 120
OP_IF = 99
OP_NOTIF = 100
OP_ELSE = 103
OP_ENDIF = 104
OP_PICK = 121
OP_SIZE = 130
OP_VER = 98
OP_ROLL = 122
OP_ROT = 123
OP_2DROP = 109
OP_2DUP = 110
OP_3DUP = 111
OP_NIP = 119

OP_CAT = 126
OP_SUBSTR = 127
OP_LEFT = 128
OP_RIGHT = 129
OP_INVERT = 131
OP_AND = 132
OP_OR = 133
OP_XOR = 134
OP_2MUL = 141
OP_2DIV = 142
OP_MUL = 149
OP_DIV = 150
OP_MOD = 151
OP_LSHIFT = 152
OP_RSHIFT = 153
OP_INVALIDOPCODE = 0xff


def num_to_opcode(num)
    if num == 0
        return OP_0
    elsif num == 1
        return OP_1
    elsif num == 2
        return OP_2
    elsif num == 3
        return OP_3
    elsif num == 4
        return OP_4
    elsif num == 5
        return OP_5
    elsif num == 6
        return OP_6
    elsif num == 7
        return OP_7
    elsif num == 8
        return OP_8
    elsif num == 9
        return OP_9
    elsif num == 10
        return OP_10
    elsif num == 11
        return OP_11
    elsif num == 12
        return OP_12
    elsif num == 13
        return OP_13
    elsif num == 14
        return OP_14
    elsif num == 15
        return OP_15
    elsif num == 16
        return OP_16
    end
    throw "Unsupported OP CODE"
end