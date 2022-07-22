pragma solidity^0.6.0;

// hello 为合约名字
// 0xd9145CCE52D386f254917e481eB44e9943F39138 合约地址
contract hello {
    // 定义状态变量，将会存放在以太坊世界状态树中，全球计算机都会为你保存该变量
    string hellomsg; // 思考：存放在哪里？

    constructor(string memory _msg) public {
        hellomsg = _msg;
    }

    // 设置消息
    function setMsg(string memory _msg) public {
        hellomsg = _msg;
    }

    // 获取消息
    function getMsg() public view returns (string memory) {
        return hellomsg;
    }
}