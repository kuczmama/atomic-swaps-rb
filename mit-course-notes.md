# MIT Cryptocurrency Course

## 1. Signatures, Hashing, Hash Chains, e-cash, and Motivation

*Signature*

3 functions

generateKeys(): public, private key
sign(private_key, message): message_signature
verify(public_key, message, message_signature)


## 2. Proof of Work and Mining

Raft, Paxos, etc algorithms can handle nodes going offline, but they don't work for malicious nodes.

Sybil attack - when a bunch of malicious nodes crowd out the good nodes when getting distributed consensus
    - To prevent a sybil attack, you need to make creating an identity costly

We can say we have a lot of work, if we can get a large number of leading zeros in a sha256 hash, for example

**Leading Zeros**
echo "Tadge 4233964024" | sha256sum

The bitcoin mining algorithm isn't actually the number of leading zeros, but it looks for a hash less than a specific number, which can be adjusted.

000000007e9f5bb5a25b6a0d1512095bd415840a94e2f2fe93386898947dcb07

8 zero's is 4 bytes or 2^32 attempts needed

For example in the above message, 4233964024 is the nonce

message - m
    mₙ = (data, hₙ₋₁)
nonce - r (a number)
target - t - a number that we need to be less than
hash(m, r) = h; h < t

e.g.

m₂ = (data₂, hash(data₁, nonce₁) )

**Mining Adjustment**

A mining adjustment happens every 2016 block.  The algorithm looks at the time of the current block, and the block that was mined 2016 blocks ago.  If the timestamp of the current block minus the last timestamp adjustment block is equal to two weeks, no adjustment is made.  But, if the delta is greater than two weeks, the algorithm is made easier, but if the delta is less than two weeks, the work is made harder.

**Block Anatomomy**

Prev: Previous Hash
msg: current message
nonce: nonce for work

The hash of the above things are used as an identifier for a given block, so it can be used as a "previous" pointer to "chain" the blocks together

*Interesting* - The bitcoin nonce space isn't big enough, so you need to put a nonce in the msg of a bitcoin transaction


## PART 4 : UTXO Model and Transactions

A replay attack is when you broadcast the same transaction twice...

Input:

- prev tx id
- scriptSig - unlocking script
- index

Output:

- scriptPubKey - locking script
- value


**Consensus Rules**

- Sum(inputs) >= Sum(outputs)
    - except for "coinbase" transactions
    - why not equal? fees

A fee is implicit... it is the difference between the sum of the inputs and the sum of the outputs

- For every input, eval(scriptSig + scriptPubKey) == true

- output has not already been spent

- lock_time?

**Script Sig & Script Pub Key**


**CoinBase Transaction**
    - The company Coinbase is named after this
    - It is the first transaction in a block, it gives out the block reward to the miner
    - It has inputs, but they are meaningless
    - It gives out the block reward plus the fees which is the sum of all transactions in the block

As an aside, I would assume that if the fees don't increase... or we don't increase the block size then that would mean miners will get less and less reward over time as we continue to half... so either Bitcoin becomes worth billions of dollars... or the whole thing falls apart :/