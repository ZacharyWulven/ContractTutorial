pragma solidity^0.6.0;


/*
角色分析
1. 平台方
* 创建拍卖
* 结束拍卖
  
2. 买方
* 竞拍（价高者得）
3. 卖方 
* 等待结果
*/

contract auction {
    // 数据记录
    address payable owner;         // 平台方
    address payable public seller;        // 卖家
    address payable public highestBuyer;  // 最高价买方，这里为了测试使用了 public，如果是私下拍卖会就不要写了
    uint256 public highestAmount; // 最高价金额
    bool isEnd = false;    // 是否结束竞拍

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can do it !");
        _;
    }

    constructor(address payable _seller) public {
        owner = msg.sender;
        seller = _seller;

    }

    // 竞拍
    function auctionBid(uint256 amount) public payable {
        // 每次喊价必须比当前最高价高
        require(amount > highestAmount, "amount must > highestAmount");
        require(msg.value == amount, "msg.value need equal to amount");
        require(!isEnd, "auction must not end");
        require(msg.sender != address(0), "address is not 0");

        // 退回之前出价的钱给人家
        if (highestAmount > 0) { // 说明之前有买家出价，退钱给原买家
           highestBuyer.transfer(highestAmount);
        }

        highestAmount = amount;
        highestBuyer = msg.sender;

    }

    // 结束竞拍
    function endAuction() public payable onlyOwner {
        require(!isEnd, "auction must not end");
        isEnd = true;
        
        // 给卖家打钱
        uint256 benefit = highestAmount * 95 / 100;
        seller.transfer(benefit);
        owner.transfer(highestAmount - benefit);
    }




}
