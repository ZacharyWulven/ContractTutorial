pragma solidity^0.6.0;

/*
核心功能
* 下注
* 开奖
* 平台抽成
*/

struct Player {
    address payable addr; // 玩家地址
    uint256 amount; // 下注金额
}

contract bet {
    // 记录平台方地址
    address payable owner;

    // 下注：分奖金按下注的比例分配, 需要记录用户的下注金额

    Player[] bigs; // 记录下大注的用户
    Player[] smalls;  // 记录下小注的用户

    uint256 public totalBigAmount; // 记录大的总金额
    uint256 public totalSmallAmount; // 记录小的总金额

    // 可以指定一个下注时间，但自己操作慢了可能有问题，改用 gameover

    uint256 gameTimeout;

    bool gameover;

    constructor() public {
        owner = msg.sender;
        gameTimeout = now + 15;
    }

    // 下注
    function betIt(uint256 amount, bool isBig) public payable {
        require(amount > 0, "amount must > 0");
        require(msg.value == amount, "msg.value must is equal to amount");
        require(!gameover, "game over !");
     //   require(gameTimeout > now, "");
        Player memory player = Player(msg.sender, amount);


        if (isBig) {
            bigs.push(player);
            totalBigAmount += amount;
        } else {
            smalls.push(player);
            totalSmallAmount += amount;
        }
    }

    // 可以指定一个下注时间 
    function openBet() public payable {
        require(!gameover, "game over !");
        require(now > gameTimeout, "game must timeout");
        require(totalBigAmount > 0 || totalSmallAmount > 0, "either totalSmallAmount or totalBigAmount > 0");
        gameover = true;
        // 开奖：计算一个 18 以内的随机数
        uint256 random = uint256(keccak256(abi.encode(msg.sender, totalSmallAmount, totalBigAmount, now))) % 15 + 3;
        if (random > 10) {
            // big 大分小的钱 奖金等于 = 用户下注金额 + 赢取的奖金
             for (uint256 i = 0; i < bigs.length; i++) {
                Player memory player = bigs[i];
                uint256 betAmount = player.amount;
                uint256 amount = betAmount + getBonus(totalSmallAmount, betAmount, totalBigAmount);
                player.addr.transfer(amount);
             }
        } else {
            // small
             for (uint256 i = 0; i < smalls.length; i++) {
                Player memory player = smalls[i];
                uint256 betAmount = player.amount;
                uint256 amount = betAmount + getBonus(totalBigAmount, betAmount, totalSmallAmount);
                player.addr.transfer(amount);
             }
        }
        // 剩下是平台抽成的钱
        owner.transfer(address(this).balance);
    }

    function getBonus(uint256 losserTotalAmount, uint256 betAmount, uint256 winerTotalAmount) private pure returns (uint256) {
        uint8 commissionRate = 10; // 平台抽成 10 % 
        uint256 bonus = losserTotalAmount * betAmount / winerTotalAmount * (100 - commissionRate) / 100;
        return bonus;
    }

}

