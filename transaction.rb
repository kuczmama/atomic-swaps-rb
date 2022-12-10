require_relative 'transaction_helper'
# This class is made to 

# https://createbitcointransaction.com/

class Transaction
    VERSION_BYTES = 4

    def initialize()
        @version_str = to_little_endian(1, VERSION_BYTES)
        @inputs = []
    end

    def set_version(version)
        @version_str = to_little_endian(version, VERSION_BYTES)
        self
    end

    # Add a new input to the transaction
    #
    # @param prev_tx_id - the previous transaction id
    # @param - prev_tx_output_num - the vout of the previous transaction
    # @param - a string representing the unlocking script
    def add_input(prev_tx_id, prev_tx_output_num, unlocking_script)
        input = ""
        input += to_little_endian(prev_tx_id, 32)
        input += to_little_endian(prev_tx_output_num, 4)
        # input += to_little_endian(prev_tx_locked_amt)
        # input += to_little_endian(prev_tx_locking_script)
        @inputs.push(input)
        self
    end

    def to_s
        "#{@version_str} #{@inputs.join('')}"
    end
end