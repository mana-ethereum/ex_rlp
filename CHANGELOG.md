# 0.3.0
* Remove protocols for Map because it overrides custom struct protocols. (https://github.com/exthereum/ex_rlp/pull/12)
# 0.2.1
* Improve typespecs to allow for integers as a valid value to encode in RLP. (https://github.com/exthereum/ex_rlp/pull/6)
# 0.2.0
* Breaking: added option to encode RLP to either hex strings (`"8055FF"`) or binaries (`<<0x80, 0x55, 0xFF>`). The default is now `:binary`. (https://github.com/exthereum/ex_rlp/pull/3)
* Added typespecs and additional test coverage through doctests. (https://github.com/exthereum/ex_rlp/pull/3)
# 0.1.1
* Adds protocols for encoding/decoding maps (https://github.com/exthereum/ex_rlp/commit/76451f707a961a3985e00be4ed3ea77fc27d5c83)
