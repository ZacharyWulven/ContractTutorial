pragma solidity^0.6.0;

import "./IERC2000.sol";
import "./strings.sol";
import "./SafeMath.sol"; // copy from github OpenZeppelin

// 本例通过把 address 地址转为 string 模型进行 ERC20 开发

contract Token is IERC2000 {
    
    using strings for string;
    
    // 为 uint256 使用 SafeMath
    using SafeMath for uint256;

    string tokenName;
    string tokenSymbol;
    address admin;
    uint256 tokenTotalSupply;
    
    mapping(string=>uint256) _balances;
    
    // 自定义修饰符
    modifier onlyAdmin() {
        require(msg.sender == admin, "onlyAdmin can do it");
        _;
    }
    
    constructor(string memory _name, string memory _symbol) public {
        tokenSymbol = _symbol;
        tokenName = _name;
        admin = msg.sender;
        tokenTotalSupply = 0;
    }
    
    function name() override external view returns (string memory) {
        return tokenName;
    }
    
    function symbol() override external view returns (string memory) {
        return tokenSymbol;
    }
    
    function totalSupply() override external view returns (uint256) {
        return tokenTotalSupply;
    }

    function balanceOf(string calldata _owner) override external view returns (uint256 balance) {
        return _balances[_owner];
    }
    
    // onlyAdmin
    function transfer(string calldata _from, string calldata _to, uint256 _value) override external onlyAdmin returns (bool success) {
        // 应该注册的用户才行
        // to 不为空
        require(!_to.isEqual(""), "to msut not be null");
        // from 余额
        require(!_from.isEqual(""), "from must not be null");

        require(_value > 0, "value must > 0");
        require(_balances[_from] > _value, "user's balance is not enough");

        _balances[_from] = _balances[_from].sub(_value);
        _balances[_to] = _balances[_to].add(_value);
        
        emit Transfer(_from, _to, _value);
        
    }
    
    
    // 解决发行问题，增加 mint 
    function mint(string calldata _to, uint256 _value) external onlyAdmin {
        require(!_to.isEqual(""), "to msut not be null");
        require(_value > 0, "value must > 0");

        tokenTotalSupply = tokenTotalSupply.add(_value);
        _balances[_to] = _balances[_to].add(_value);
        
        // system 给的
        emit Transfer("system", _to, _value);
    }
    
    // 解决销毁问题，增加 burn
    function burn(string calldata _from, uint256 _value) external onlyAdmin {
        require(_value > 0, "value must > 0");
        require(!_from.isEqual(""), "from must not be null");
        require(_balances[_from] > _value, "user's balance is not enough");

        tokenTotalSupply = tokenTotalSupply.sub(_value);
        _balances[_from] = _balances[_from].sub(_value);
        
        emit Transfer(_from, "system", _value);
    }
    
    
    
    
    // 实际是一种授权行为, address 转为 string 后授权就没用了，可以不写了
    /*
    function transferFrom(string calldata _from, string calldata _to, uint256 _value) override public returns (bool success) {

    }
    
    function approve(string calldata _from, string calldata _spender, uint256 _value) override public returns (bool success) {
        
    }
    
    function allowance(string calldata _owner, string calldata _spender) override public view returns (uint256 remaining) {
        
    }
    */

    
}