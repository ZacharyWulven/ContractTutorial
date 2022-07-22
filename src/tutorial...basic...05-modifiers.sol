pragma solidity^0.6.0;

contract modifiers_demo {
    // 演示三种不同演示的函数
    uint256 totalAmount;
    
    constructor() public {
        totalAmount = 0;
    }

    // 红颜色的函数：带 payable
    // 消耗 gas + eth
    function payamount() public payable {
        totalAmount -= 10;

    }

    // 橘红色的函数: 修改状态变量的函数
    // 只消耗 gas
    function setAmount(uint256 amount) public {
        totalAmount = amount;
    }

    // 蓝色的函数：带 view、pure 是蓝色的
    // 无消耗
    function getAmount() public view returns (uint256) {
        return totalAmount;
    }

}