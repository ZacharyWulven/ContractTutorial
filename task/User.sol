pragma solidity^0.6.0;

import "./IUSER.sol";
import "./strings.sol";


contract User is IUSER {
    // 使用 library strings
    using strings for string;
    
    // 定义数据结构
    mapping(string=>string) users;
    
    // 定义管理员
    address admin;
    
    constructor() public {
        admin = msg.sender;
    }
    
    // 自定义修饰符
    modifier onlyAdmin() {
        require(msg.sender == admin, "onlyAdmin can do it");
        _;
    }
    
    
    function register(string calldata username, string calldata passwd) override external onlyAdmin {
        // 1. 用户不存在
        // 2. 用户名和密码不为空
        require(users[username].isEqual(""), "user must not exists");
        require(!username.isEqual(""), "user name is null");
        require(!passwd.isEqual(""), "user passwd is null");

        users[username] = passwd;
        
    }
    
    function login(string calldata username, string calldata passwd) override external view returns (bool) {
        if (username.isEqual("") || passwd.isEqual("")) {
            return false;
        }
        
        return users[username].isEqual(passwd);
        
        
    }
    
    
}