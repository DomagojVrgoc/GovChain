pragma solidity ^0.4.18;

contract StelaHash{

	mapping (bytes32 => bytes32) public roots_chain;
    mapping (bytes32 => uint) public timestamps;
    bytes32 public last_hash;
    address pubic publisher_address;

	function StelaHash() public {
        publisher_address = msg.sender;
        last_hash = 1;
    }

	function add_root(bytes32 root_hash) public {
        assert(block.timestamp - timestamps[last_hash] > 20 * 3600000);
		assert(msg.sender == publisher_address);
       	assert(roots_chain[root_hash] != 0);
        timestamps[root_hash] = block.timestamp;
        roots_chain[root_hash] = last_hash; 
        last_hash = root_hash;
	}
}
