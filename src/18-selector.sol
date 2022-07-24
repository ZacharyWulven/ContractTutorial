pragma solidity^0.8.0;

import "./17-IERC-20.sol";

contract selector {

    function getBalanceOfBytes() public pure returns (bytes4, bytes4) {
        IERC20 erc20;
        // 自己计算函数签名 只需要参数类型
        bytes4 signature = bytes4(keccak256("balanceOf(address)"));

        // 返回 balanceOf 函数的签名
        return (erc20.balanceOf.selector, signature);
    }


}
