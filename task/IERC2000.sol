pragma solidity^0.6.0;


interface IERC2000 {
    
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function totalSupply() external view returns (uint256);

    function balanceOf(string calldata _owner) external view returns (uint256 balance);
    function transfer(string calldata _from, string calldata _to, uint256 _value) external returns (bool success);
    
    event Transfer(string indexed _from, string indexed _to, uint256 _value);

    // 实际是一种授权行为, address 转为 string 后授权就没用了，可以不写了
    // function transferFrom(string calldata _from, string calldata _to, uint256 _value) external returns (bool success);
    // function approve(string calldata _from, string calldata _spender, uint256 _value) external returns (bool success);
    // function allowance(string calldata _owner, string calldata _spender) external view returns (uint256 remaining);

    // event Approval(string indexed _owner, string indexed _spender, uint256 _value);

}