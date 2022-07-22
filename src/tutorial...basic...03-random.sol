pragma solidity^0.6.0;

contract random_demo {
    function getRandom() public view returns (uint256) {
        // 计算一个100以内的随机数
        // 根据哈希防碰撞的特性，输入不同，产生不同输出，就是随机值
        // now 当前时间
        bytes32 hash = keccak256(abi.encode(now, msg.sender, block.number, "salt"));
        
        return uint256(hash) % 100;
    }


}