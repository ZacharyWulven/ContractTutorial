pragma solidity^0.6.0;

contract function_deom {

    // 比较两个字符串是否相等
    function isEqualToString(string memory a, string memory b) public pure returns (bool) {
        // 可以先计算字符串长度，如果长度为 0 则不允许计算


        // hashA 实际是一个数组, 通过 bytes 把字符串转成数组
        bytes memory hashA = bytes(a);
        bytes memory hashB = bytes(b);

        if (hashA.length == 0 || hashB.length == 0) {
            return false;
        }
        bytes32 hashAA = keccak256(hashA);
        bytes32 hashBB = keccak256(hashB);


        
        return hashAA == hashBB;
    }

}