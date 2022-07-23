pragma solidity^0.6.0;

/*
    角色设计：土豪发红包
    吃瓜群众：抢红包
*/

contract redpacket {
    // 定义土豪
    address tuhao;
    uint256 totalAmount; // 红包金额
    uint256 count;  // 红包数量
    bool isEqual; // 等额红包

    mapping(address=>bool) grabedMap; // 抢过了不能再抢

    // 构造函数：土豪执行，顺便发红包
    constructor(uint256 _count, bool ok) public payable {
        require(msg.value > 0, "value must > 0");
        tuhao = msg.sender;
        count = _count;
        isEqual = ok;
        totalAmount = msg.value;
    }

    // 抢红包
    function grabRedpacket() public payable {
        require(count > 0, "count must > 0");
        require(totalAmount > 0, "totalAmount must > 0");
        require(!grabedMap[msg.sender], "msg.sender must not grabed");
        grabedMap[msg.sender] = true;

        // 如果是最后一个红包-- 直接拿走
        if (count == 1) {
            msg.sender.transfer(totalAmount);
            totalAmount = 0;
        } else {
            // 是否为等额
            if (isEqual) {
                uint256 amount = totalAmount / count;
                totalAmount -= amount;
                msg.sender.transfer(amount);
            } else {
                // 计算一个 10 以内的随机值
                uint256 random = uint256(keccak256(abi.encode(msg.sender, tuhao, count, totalAmount, now))) % 8 + 1;
                uint256 amount = totalAmount * random / 10;
                totalAmount -= amount;
                msg.sender.transfer(amount);
            }
        }
        count -= 1;
    }

    function getTotalAmount() public view returns (uint256) {
        return totalAmount;
    }

    function getCount() public view returns (uint256) {
        return count;
    }

}
