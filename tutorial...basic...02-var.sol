pragma solidity^0.6.0;

contract simpleDataType {
    // 定义状态变量
    // public 类型的变量自动提供查询方法
    string public name;
    uint8 public age;
    string public job;
    int256 salary;


    // 字节类型 bytes32 是哈希值返回结果
    bytes32 public personHash;

    // 构造函数
    constructor(string memory _name, uint8 _age, string memory _job, int256 _salary) public {
        name = _name;
        age = _age;
        job = _job;
        salary = _salary;
        // keccak256 以太坊的哈希计算函数
        // 之前版本可以传多个参数，升级后只能传一个参数，这时我们需要使用 abi.encode 编码进行编码
        // 0x8f1646852a221db355f721f1a6bf3010f0c3cc9d897b19fe178fd0d93d93b8a2
        personHash = keccak256(abi.encode(name, age, job, salary));
    }

    function getSalary() public view returns (int256) {
        return salary;
    }
}