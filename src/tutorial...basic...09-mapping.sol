pragma solidity^0.6.0;
pragma experimental ABIEncoderV2;


// 学生结构
struct Student {
    string name;
    string sex;
    uint8 age;

}

contract mapping_demo {
    // 学生编号作为 key，指向学生信息
    mapping(uint256=>Student) students;
    uint256 count;

    constructor() public {
        count = 0;
    }

    function addStudent(string memory n, string memory s, uint8 a) public {
        Student memory stu = Student(n, s, a);
        // mapping 的访问或修改 都是通过 key
        students[0] = stu;
    }


    function getStudent(uint256 index) public view returns (Student memory) {
        // 如果 key 对应的 value 没有，会找不到，不会像数组越界
        return students[index];
    }
}