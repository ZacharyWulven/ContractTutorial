pragma solidity ^0.4.21;


contract Asset {
    address public issuer;
    
    mapping (address=>uint) public balances;

    event Send(address from, address to, uint amount);
    

    constructor() {
        issuer = msg.sender;
    }

    function issue(address receiver, uint amount) public returns (uint) {
        require(msg.sender == issuer, "issue need issuer");
        balances[receiver] += amount;
        return amount;
    }

    function send(address receiver, uint amount) public {
        require(balances[msg.sender] >= amount, "balances is not enough");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Send(msg.sender, receiver, amount);

    }    
}
