pragma solidity^0.6.0;
pragma experimental ABIEncoderV2;


// 定义结构，0.6 后结构定义可以放在合约外了， 
struct Person {
    string name;
    uint8 age;
    bool isMan;
    uint256 salary;
}

contract struct_demo {
    Person[] persons;
    // 构造 person 对象

    constructor() public {

    }

    function addPerson(string memory name_, uint8 age_, bool man_, uint256 salary_) public {
        Person memory p = Person(name_, age_, man_, salary_);
        persons.push(p);
    }

    function findPerson(uint256 index) public view returns (Person memory) {
        return persons[index];
    }

    function setAge(uint256 index, uint8 a) public {
         Person memory p = persons[index]; 
         p.age = a;  // 修改无效

    }

    function setAge2(uint256 index, uint8 a) public {
        persons[index].age = a; // 修改有效

    }

    function setAge3(uint256 index, uint8 a) public {
        /*
            本地变量就两种选择 memory 或 storage
            memory 相当于值传递，值拷贝，拷贝后得到的对象与原对象没有一点关系
            storage 相当于引用传递，指针赋值，赋值后得到的对象会影响原对象
        */
         Person storage p = persons[index]; // 修改有效
         p.age = a;

    }
}