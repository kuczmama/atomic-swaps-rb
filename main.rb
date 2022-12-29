require 'bitcoin'

key = Bitcoin::Key.generate
key.priv
key.pub
key.addr

sig = key.sign("data")
key.verify("data", sig)