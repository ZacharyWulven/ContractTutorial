pragma solidity^0.6.0;


// 字符串比较

library strings {
    function isEqual(string memory a, string memory b) internal pure returns (bool) {
        bytes32 hashA = keccak256(abi.encode(a));
        bytes32 hashB = keccak256(abi.encode(b));
        
        return hashA == hashB;
    }
}