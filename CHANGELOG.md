# 0.5.3
* Handle invalid RLP when decoding (with respective tests from [ethereum/tests](https://github.com/ethereum/tests/blob/develop/RLPTests/invalidRLPTest.json)) (https://github.com/mana-ethereum/ex_rlp/pull/27)
* Update [ethereum/tests submodule](https://github.com/ethereum/tests) (https://github.com/mana-ethereum/ex_rlp/pull/23 and https://github.com/mana-ethereum/ex_rlp/pull/25)
# 0.5.2
* reverts https://github.com/mana-ethereum/ex_rlp/pull/20 which introduced encoding bug (https://github.com/mana-ethereum/ex_rlp/pull/22)
* defensive guard checking in encoder (https://github.com/mana-ethereum/ex_rlp/pull/21)
# 0.5.1
* Fix encoding of binary lists with trailing zeroes (https://github.com/mana-ethereum/ex_rlp/pull/20)
# 0.5.0
* Optimize decoding (https://github.com/mana-ethereum/ex_rlp/pull/19)
# 0.4.1
* Fix decoding of large binary lists introduced by changes in 0.4.0. (https://github.com/mana-ethereum/ex_rlp/pull/17)
# 0.4.0
* Improve speed with list prefixing and tail-call optimizations. (https://github.com/mana-ethereum/ex_rlp/pull/15)
# 0.3.1
* Upgrade elixir version. (https://github.com/exthereum/ex_rlp/pull/14)
# 0.3.0
* Remove protocols for Map because it overrides custom struct protocols. (https://github.com/exthereum/ex_rlp/pull/12)
# 0.2.1
* Improve typespecs to allow for integers as a valid value to encode in RLP. (https://github.com/exthereum/ex_rlp/pull/6)
# 0.2.0
* Breaking: added option to encode RLP to either hex strings (`"8055FF"`) or binaries (`<<0x80, 0x55, 0xFF>`). The default is now `:binary`. (https://github.com/exthereum/ex_rlp/pull/3)
* Added typespecs and additional test coverage through doctests. (https://github.com/exthereum/ex_rlp/pull/3)
# 0.1.1
* Adds protocols for encoding/decoding maps (https://github.com/exthereum/ex_rlp/commit/76451f707a961a3985e00be4ed3ea77fc27d5c83)
