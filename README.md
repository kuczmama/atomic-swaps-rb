# Overview
Here's the idea.  We have a decentralized exchange that is completely trustless, that will be able to send between any two arbitray chains.  This will be done chain by chain, and use opcodes to determine which chain will be sent.

There will be no counterparty risk because we won't hold any coins.  But, we do take a X% transaction fee in the coin that you are sending.

https://bitcointalk.org/index.php?topic=193281.msg2224949#msg2224949

# Atomic Swap Protocol

1. Alice picks a random number X
2. Alice creates Tx1:

Tx1:
Pay w BTC to <B's public key> if x for H(x) known and signed by B

## Bitcoin Scripting

https://en.bitcoin.it/wiki/Script


Bitcoin OPCodes have some scripting to make it so a bitcoin transaction goes through

## Bitcoin Transaction

A bitcoin transaction has 4 parts

1. Version: 4 bytes
2. Inputs
    - Input Count:
        - Prev TXid: ID of transaction you're spending
        - vout: output from the transaction
        - scriptSig size: size of script sig
        - scriptSig Unlocking SCript: script to unlock transaction
        - sequence: p4 bytes ffffffff
3. Outputs
    - Output count:
         - value: 8 bytes in satoshis
         - ScriptPubKey size: variable size
         - Script PubKey: A script that locks the output
4. Locktime

The scriptSig is provided as an output to script pubkey

- A bitcoin address is a hash of the public key
- Output = Bitcoin Value + Locking Script

## Multisig example
https://gist.github.com/gavinandresen/3966071

## Pay To Public Key Hash (P2PKH)
https://www.youtube.com/watch?v=47dKdtOXANo
If Alice sends Bitcoin to Bob that means she created a locking script/scriptPubkey to Bob's bitcoin address

Input
<signature> <public Key>

OP_DUP OP_HASH_160 <Bitcoin Address> OP_EQUAL_VERIFY OP_CHECKSIG

### Validation Script

= Input + Output
eg:
<signature> <public Key>  | OP_DUP OP_HASH_160 <Bitcoin Address> OP_EQUAL_VERIFY OP_CHECKSIG

### Stack


<bitcoin addres>
h(public key)
<Public Key>
<Signature>


### Example Tx

01000000017967a5185e907a25225574544c31f7b059c1a191d65b53dcc1554d339c4f9efc010000006a47304402206a2eb16b7b92051d0fa38c133e67684ed064effada1d7f925c842da401d4f22702201f196b10e6e4b4a9fff948e5c5d71ec5da53e90529c8dbd122bff2b1d21dc8a90121039b7bcd0824b9a9164f7ba098408e63e5b7e3cf90835cceb19868f54f8961a825ffffffff014baf2100000000001976a914db4d1141d0048b1ed15839d0b7a4c488cd368b0e88ac00000000

Version: 01000000
Inputs:
    Input Count: 01
        prev txid: 7967a5185e907a25225574544c31f7b059c1a191d65b53dcc1554d339c4f9efc
        vout: 01000000
        scriptSig size/unlock script size: 6a
        scriptSig/unlockScript: 47304402206a2eb16b7b92051d0fa38c133e67684ed064effada1d7f925c842da401d4f22702201f196b10e6e4b4a9fff948e5c5d71ec5da53e90529c8dbd122bff2b1d21dc8a90121039b7bcd0824b9a9164f7ba098408e63e5b7e3cf90835cceb19868f54f8961a825
        sequence: ffffffff
Outputs
    output count: 01
        value: 4baf210000000000
        scriptPubKey size: 19
        script pubKey: 76a914db4d1141d0048b1ed15839d0b7a4c488cd368b0e88ac
Locktime:
    00000000

## Pay to Script Hash

With a pay to script hash, your locking script is simply a hash of a script.  The script is only revealed when you try to spend those transactions?

## Links

Bitcoin IDE: https://wschae.github.io/build/editor.html
https://learnmeabitcoin.com/technical/scriptPubKey
https://komodoplatform.com/en/

## Example from ChatGPT

```bash
# Alice's Bitcoin public key
alice_pubkey = "<alice's public key>"

# Bob's Monero public key
bob_pubkey = "<bob's public key>"

# Timelock for the swap, in blocks
timelock = 100

# Hash of the secret pre-agreed upon by Alice and Bob
secret_hash = "<secret hash>"

# The script for Alice's output
alice_output = [
    # Alice can spend the output if she provides the secret
    OP_SHA256, secret_hash, OP_EQUAL,

    # OR she can spend the output after the timelock expires
    # and she provides a valid signature from her private key
    OP_IF,
        OP_CHECKSEQUENCEVERIFY, OP_DROP,
        alice_pubkey, OP_CHECKSIG,
    OP_ELSE,
        # Bob can spend the output if he knows the secret
        OP_HASH160, bob_pubkey, OP_EQUALVERIFY,
        OP_CHECKSIG,
    OP_ENDIF
]

# The script for Bob's output
bob_output = [
    # Bob can spend the output if he knows the secret
    OP_SHA256, secret_hash, OP_EQUAL,
    OP_HASH160, bob_pubkey, OP_EQUALVERIFY,
    OP_CHECKSIG,

    # OR he can spend the output after the timelock expires
    # and he provides a valid signature from his private key
    OP_IF,
        OP_CHECKSEQUENCEVERIFY, OP_DROP,
        bob_pubkey, OP_CHECKSIG,
    OP_ELSE,
        # Alice can spend the output if she knows the secret
        OP_SHA256, secret_hash, OP_EQUAL,
        alice_pubkey, OP_CHECKSIG,
    OP_ENDIF
]

# The transaction input that is being spent
input = {
    "txid": "<previous transaction id>",
    "vout": 0,
    "scriptSig": "<input script>"
}

# The transaction outputs
outputs = [
    {"scriptPubKey": alice_output, "value": 100000},
    {"scriptPubKey": bob_output, "value": 200000}
]

# Create the raw transaction
rawtx = createrawtransaction(input, outputs)

# Sign the transaction
signedtx = signrawtransaction(rawtx)

# Broadcast the transaction
sendrawtransaction(signedtx)
```

## OP_EQUAL example

<input 1> <input 2> OP_EQUAL

```s
1234abcd OP_SHA256 E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855 OP_EQUAL
```

## OP_SHA256
<input> OP_SHA256

## OP_CHECKMULTISIGVERIFY

```s
2 <pubkey1> <pubkey2> <pubkey3> 3 OP_CHECKMULTISIGVERIFY
```

In this example, the 2 at the beginning of the script indicates that at least two of the provided public keys must sign the transaction in order for it to be valid. Then, three public keys (<pubkey1>, <pubkey2>, and <pubkey3>) are pushed onto the stack. Finally, the 3 is pushed onto the stack and the OP_CHECKMULTISIGVERIFY opcode is executed.

## Pay To Public Key Hash

"OP_HASH160 <H(x)> OP_EQUAL <pubkeyB> OP_CHECKSIGVERIFY"

Sure, this script is a simple pay-to-pubkey-hash (P2PKH) script, which is commonly used in bitcoin transactions to spend outputs that have been locked to a specific public key hash. The script performs the following steps:

The OP_HASH160 opcode is used to compute the hash of the public key, which is then pushed onto the stack.

The OP_EQUAL opcode is used to compare the hash of the public key to the value that is provided in the script (in this case, <H(x)>). If the values match, the script continues execution. If the values do not match, the script will be invalid and the transaction will be rejected.

The public key (<pubkeyB>) is provided in the script and is pushed onto the stack.

The OP_CHECKSIGVERIFY opcode is used to verify the signature of the transaction using the provided public key. If the signature is valid, the script continues execution. If the signature is invalid, the script will be invalid and the transaction will be rejected.

Overall, this script checks that the public key hash provided in the script matches the hash of the provided public key, and that the signature of the transaction is valid for that public key. If both of these checks pass, then the script will be considered valid and the transaction will be accepted.

In bitcoin, the scriptPubKey (or "script public key") is the script that specifies the conditions that must be met in order for someone to spend the funds that are locked in a particular output. This script is stored in the output of a transaction, and it is used to determine whether the transaction input that is trying to spend the output is valid.


