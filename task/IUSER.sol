pragma solidity^0.6.0;

// 定义用户接口, 接口名称要与文件名相同
// string->string
interface IUSER {
    // 注册
    // 接口类型相应被继承用 external
    // 让用户可以用 address 类型 
    // external 情况下用 calldata，public 情况用 memory
    function register(string calldata username, string calldata passwd) external ;
    
    // 登录
    // 要有 view 关键字，因为登录要访问存储的变量
    function login(string calldata username, string calldata passwd) external view returns (bool);
    
    
    // 作业：更改密码
    
    
    
    
}