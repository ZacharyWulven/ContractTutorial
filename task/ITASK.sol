pragma solidity^0.6.0;

interface ITASK {
    // 任务的四大状态：发布(status==0)，接受(1)，提交(2)，确认(3)
    
    // 参数： 发布人、密码、描述、奖金
    function issueTask(string calldata _issuer, 
                       string calldata _passwd, 
                       string calldata _desc,
                       uint256 _bonus) external;
    
    
    function takeTask(string calldata _worker, 
                      string calldata _passwd,
                      uint256 _taskID) external;
                      
                      
    function commitTask(string calldata _worker,
                        string calldata _passwd,
                        uint256 _taskID) external;


    function confirmTask(string calldata _issuer,
                        string calldata _passwd,
                        uint256 _taskID,
                        uint8 _status) external;
                        
                        
    
    
    
    
}