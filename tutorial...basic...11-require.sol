pragma solidity^0.6.0;

contract require_deom {
    uint256 count;

    constructor() public {
        count = 30;
    }

    function setCount(uint256 c) public {
        // assert(cond) 如果条件不成立，则报错并且扣光 gas, 状态回退
        count = 25;
        assert(c > count);
     //   count = c;
    }

    function setCount2(uint256 c) public {
        // require(cond), 如果条件不成立，则报错并退出
        count = 26;
        require(c > count, "c must bigger than count");
        count = c;
    }

    function getCount() public view returns (uint256) {
        return count;
    }
}

