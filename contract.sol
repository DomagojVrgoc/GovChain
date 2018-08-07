pragma solidity ^0.4.18;

contract GovChain{

	mapping (bytes32 => bytes32) public roots;
	mapping (bytes32 => bytes32) public blocks_chain;
    mapping (bytes32 => uint) public timestamps;
    bytes32 public last_block_hash;
    address public publisher_address;

	function GovChain() public {
        publisher_address = msg.sender;
        last_block_hash = 1;
    }

	function add_root(bytes32 merkle_root) public {
        assert(msg.sender == publisher_address);
        assert(block.timestamp - timestamps[last_block_hash] > 20 * 3600000);        
		// Concatenate the previous block's hash and the new Merkle root.
        bytes32 new_block_hash = sha256(last_block_hash * 2 ** 32 + merkle_root);
       	assert(roots[new_block_hash] != 0);
        roots[new_block_hash] = merkle_root;
        blocks_chain[new_block_hash] = last_block_hash;
        timestamps[new_block_hash] = block.timestamp;
        last_block_hash = new_block_hash;
	}
}
