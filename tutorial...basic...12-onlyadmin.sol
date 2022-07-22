pragma solidity^0.6.0;

contract only_admin_demo {
    address admin; // 管理员
    uint256 count;
    constructor(address owner) public {
        admin = owner;
        count = 30;
    }

    // 自定义修饰符
    modifier onlyOwner() {
        require(msg.sender == admin, "only admin can do it!");
        _; // 占位符
    }

    function setCount(uint256 c) public onlyOwner {
        count = c;
    }

    function getCount() public view returns (uint256) {
        return count;
    }
}