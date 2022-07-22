// 去调警告
// SPDX-License-Identifier:Apache-2.0
pragma solidity^0.8.7;

// deposit  withdraw.  transfer
// 账本记录 
contract bank {

    address owner;
    // 储户很多人 无法定义变量
    
    mapping(address=>uint256) _balances; // 储户账本
    string public bankName;
    uint256 public totalAmount;

    constructor(string memory _name) {
        owner = msg.sender;
        bankName = _name;
    }
    // 存款 取款 转账
    function deposit(uint256 _amount) public payable {
        require(_amount > 0, "amount must > 0");

        require(msg.value == _amount, "amount not equal value");

        _balances[msg.sender] += _amount;

        totalAmount += _amount;
        // 合约账号的钱 address(this).balance
        require(totalAmount == address(this).balance);



    }
        // 带  msg.value 和 transfer 需要  payable

    function withdraw(uint256 _amount) public payable {
        require(_amount > 0, "amount must > 0");
        require(_balances[msg.sender] >= _amount, "user's balance not enough");

        _balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        totalAmount -= _amount;
        require(totalAmount == address(this).balance);
    
    }

    function transfer(address to, uint256 _amount) public  {
        // require 解决事务问题
        require(_amount > 0, "amount must > 0");
        require(_balances[msg.sender] >= _amount, "user's balance not enough");
        // 地址是否有效
        require(address(0) != to, "to is invalid");
        
        _balances[to] += _amount;
        _balances[msg.sender] -= _amount;
        require(totalAmount == address(this).balance);

    }

    function getBalance(address _who) public view returns (uint256) {
        return _balances[_who];
    }









}
