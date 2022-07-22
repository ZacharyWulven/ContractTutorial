pragma solidity^0.6.0;
pragma experimental ABIEncoderV2;

contract array_demo {
    string[3] names; // 定长数组
    uint256[] ages;  // 动态数组
    
    constructor() public {
        names[0] = "tom"; // 对数组的访问，就是[下标]，注意不要越界
        names[1] = "Jack";

        // ages[0] = 10; 动态数组不允许访问不存在的下标
        ages.push(10); // 通过 push 添加元素
        ages[0] = 20;  // 下标 0 有元素后才可访问
    }

    function setNames(string memory name, uint256 index) public {
        names[index] = name;
    }

    function setAges(uint256 age) public {
        ages.push(age);
    }

    function getLength() public view returns (uint256, uint256) {
        return (names.length, ages.length);
    }

    // 编译报错不推荐这么写，加上 pragma experimental ABIEncoderV2; 可编译通过
    function getAllNames() public view returns (string[3] memory) {
        return names;
    }
}