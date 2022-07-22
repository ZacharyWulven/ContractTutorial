pragma solidity^0.6.0;

contract function_deom {
    // 计算 1+2+3...+100=5050
    // 返回值定义名字 result 
    function getSum() public pure returns (uint256 result) {
        uint256 sum = 0; // 临时变量
        uint256 i = 0;
        // init; cond; post
        for (i = 1; i < 101; i++) {

            sum += i;

        }
        // 定义返回值名称可不写 return
        result = sum;
      //  return sum;
    }

    // 比较两个字符串是否相等
    function isEqualToString(string memory a, string memory b) public pure returns (bool, bytes32) {

        bytes32 hashSpace = keccak256(abi.encode(""));

        // solidity 中没有对 == 运算符进行重载
        // 思路：借助 hash 函数，如果 hash(a) == hash(b) ===> a == b
        bytes32 hashA = keccak256(abi.encode(a));
        bytes32 hashB = keccak256(abi.encode(b));

        bytes32 memory hashAA = bytes(a)
        bytes32 memory hashBB = bytes(b)


        // if (hashA == hashSpace || hashB == hashSpace) {
        //     return false;
        // }

        
        return hashA == hashB;
    }

}