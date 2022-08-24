pragma solidity^0.6.0;


import "./Token.sol";
import "./ITASK.sol";
import "./User.sol";

// 因为 Token 构造函数有参数，所以这里继承 Token 时候需要传入
// 或在构造函数写
contract Task is ITASK, Token("ETHW", "ETHW") {
    
    // 使用 User
//    User _user; 使用具体类型定义
    IUSER _user;  // 使用接口定义
    constructor() public {
        _user = new User();
        
    }
    
    // 如果要升级 User 合约可以这样
    function upgradUser(address userAddr) public {
        _user = IUSER(userAddr);
    }
    
        function issueTask(string calldata _issuer, 
                       string calldata _passwd, 
                       string calldata _desc,
                       uint256 _bonus) override external {
                           
                       }
    
    
    function takeTask(string calldata _worker, 
                      string calldata _passwd,
                      uint256 _taskID) override external {
                          
                          
                      }
                      
                      
    function commitTask(string calldata _worker,
                        string calldata _passwd,
                        uint256 _taskID) override external {
                            
                            
                        }


    function confirmTask(string calldata _issuer,
                        string calldata _passwd,
                        uint256 _taskID,
                        uint8 _status) override external {
                            
                            
                            
                        }
                        
                        
    
    
    
    
}