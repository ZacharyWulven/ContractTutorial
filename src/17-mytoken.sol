// SPDX-License-Identifier:Apache-2.0
pragma solidity^0.8.0;

import "./17-IERC-20.sol";
import "./SafeMath.sol";

/*
    解决 token 发行的问题，通常两个方法
    1 设置 owner 管理员，通过管理员账户发钱
    2 提供 mint 函数

*/

contract mytoken is IERC20 {
    // 针对所有的 uint256 类型使用 SafeMath 库
    using SafeMath for uint256;

    // 定义 name
    string tokenName;
    string tokenSymbol;
    uint256 tokenTotalSupply;

    address owner;  // 管理员地址，解决 token 发行的问题

    // user's balance
    mapping(address=>uint256) _balances;
    // A->B 100, A 授权给 B 100
    // A->C 200, A 授权给 C 100
    mapping(address=>mapping(address=>uint256)) allows;


    constructor(string memory n, string memory s) public {
        tokenName = n;
        tokenSymbol = s;
        owner = msg.sender;
    }


    function mint(address _to, uint256 _value) external returns (bool success) {
        require(_value > 0, "_value must > 0");
        require(address(0) != _to, "to must a valid address");
        require(msg.sender == owner, "only owner can do it!");

        // _balances[_to] += _value;  // 这里可能会溢出
        // use SafeMath 库 进行加法
        _balances[_to] = _balances[_to].add(_value);

        tokenTotalSupply = tokenTotalSupply.add(_value);
        // 挖矿通知，from 的地址是 0
        emit Transfer(address(0), _to, _value);
        success = true; 

    }

    // implement IERC20 interface
    function name() override external view returns (string memory) {
        return tokenName;
    }

    function symbol() override external view returns (string memory) {
        return tokenSymbol;
    }

    function totalSupply() override external view returns (uint256) {
        return tokenTotalSupply;
    }

    function balanceOf(address _owner) override external view returns (uint256 balance) {
        return _balances[_owner];
    }
    function transfer(address _to, uint256 _value) override external returns (bool success) {
        require(_value > 0, "_value must > 0");
        require(address(0) != _to, "to must a valid address");
        require(_balances[msg.sender] >= _value, "user's balance must enough");

        _balances[msg.sender]  = _balances[msg.sender].sub(_value);
        _balances[_to] =  _balances[_to].add(_value);

        // 事件通知
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    // 授权转账，动用 _from 的钱, msg.sender 就是 _spender
    function transferFrom(address _from, address _to, uint256 _value) override external returns (bool success) {
        success = false;
        require(_value > 0, "_value must > 0");
        require(address(0) != _to, "to must a valid address");
        require(_balances[_from] >= _value, "user's balance must enough");

        _balances[_from] = _balances[_from].sub(_value);
        _balances[_to] = _balances[_to].add(_value);
        allows[_from][msg.sender] = allows[_from][msg.sender].sub(_value);

        emit Transfer(_from, _to, _value);
        success = true;

    }

    function approve(address _spender, uint256 _value) override external returns (bool success) {
        success = false;
        require(_value > 0, "_value must > 0");
        require(address(0) != _spender, "to must a valid address");
        require(_balances[msg.sender] >= _value, "user's balance must enough");

        allows[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        success = true;
    //    return

    }

    function allowance(address _owner, address _spender) override external view returns (uint256 remaining) {
        return allows[_owner][_spender];
    }
    
    // event 直接继承
    // event Transfer(address indexed _from, address indexed _to, uint256 _value);
    // event Approval(address indexed _owner, address indexed _spender, uint256 _value);   

}


