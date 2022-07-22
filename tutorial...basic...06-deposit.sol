pragma solidity^0.6.0;

contract deposit_demo {
    address owner;

    constructor() public {
        owner = msg.sender; // msg.sender 代表调用者
        

    }

    // 充值
    function deposit() public payable {

    }

    // 提现
    function withdraw(uint256 amount) public payable {
        // 方式一
        // 推荐使用 transfer，transfer 比 send 消耗的 gas 更少
        msg.sender.transfer(amount);
        
        // 方式二
         msg.sender.send(amount);

    }

    // 查询合约余额
    // this 可以理解为是本合约
    // address(this) 合约强转为 address 对象
    // address 内部属性 balance，获取账户余额
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}