// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
contract PROJECT_TODOLIST{
    enum options{high,medium,low}
    event taskdis(uint _id, bool _status,string _description , uint _date , string _category,options _priority);

    struct Task{
        uint id;
        bool status;
        string description;
        uint date;              //DDMMYYYY
        string category;
        options priority;
    }
    Task  task;
    Task[]  task_list;

    function Add_new(uint _id, bool _status,string memory _description , uint _date , string memory _category,options _priority) public  {
        Task memory task1 = Task(_id,_status,_description,_date,_category,_priority);
        task_list.push(task1);
    }

    function Display(uint _id) public view returns(uint,bool,string memory,uint,string memory,options){
        for (uint i = 0; i < task_list.length; i++) {
            if (task_list[i].id == _id) {
             Task storage task_curr = task_list[i];
                return (task_curr.id, task_curr.status, task_curr.description, task_curr.date, task_curr.category,task_curr.priority);
            }
        }
            revert("Task not found");
    }

     function DisplayTasks() public view returns (Task[] memory) {
    return task_list;
    }

    function Change_status(uint _id,bool _newstatus ) public{
        for (uint i = 0; i < task_list.length; i++) {
            if (task_list[i].id == _id) {
                task_list[i].status = _newstatus;
                return;
            }
        }
    }

    function Delete(uint _id) public {
         for (uint i = 0; i < task_list.length; i++) {
            if (task_list[i].id == _id) {
                for(uint k=i;k<task_list.length-1;k++){
                task_list[k]=task_list[k+1];
                }
                break;
            }
          
        }
        task_list.pop();
        return;
    }

    function Update(uint _id, bool _status,string memory _description , uint _date , string memory _category,options _priority) public {
        for (uint i = 0; i < task_list.length; i++) {
            if (task_list[i].id == _id) {
               Task memory task1 = Task(_id,_status,_description,_date,_category,_priority);
               task_list[i]=task1;
            }
        }
        revert("Task to be updated not found");
    }

    function Sort_bypriority() public {
         for (uint i = 0; i < task_list.length; i++) {
            for(uint j =0;j<task_list.length-i-1;j++){
                if(task_list[j].priority>task_list[j+1].priority){
                    Task memory task1;
                    task1=task_list[j];
                    task_list[j]=task_list[j+1];
                    task_list[j+1]=task1;
                }
            }
         }
    }

     function Viewbystatus(bool _status) public {
          for (uint i = 0; i < task_list.length; i++) {
            if(task_list[i].status=_status){
                emit taskdis(task_list[i].id, task_list[i].status, task_list[i].description, task_list[i].date, task_list[i].category,task_list[i].priority);
            }
         }
    }

    function EditT(uint _id, string memory des, string memory categ, uint d_d) public {
        string memory a = "" ;
        uint b = 0;
        if (keccak256(abi.encodePacked(des)) != keccak256(abi.encodePacked(a))) {
            for (uint i=0; i < task_list.length ; i++) 
            {
                
                if (_id == task_list[i].id) {
                    task_list[i].description = des;
                }
            }
        }

        if (keccak256(abi.encodePacked(categ)) != keccak256(abi.encodePacked(a))) {
            for (uint i=0; i < task_list.length ; i++) 
            {
                
                if (_id == task_list[i].id) {
                    task_list[i].category = categ;
                }
            }
        }

        if (keccak256(abi.encodePacked(d_d)) != keccak256(abi.encodePacked(b))) {
            for (uint i=0; i < task_list.length ; i++) 
            {
                
                if (_id == task_list[i].id) {
                    task_list[i].date = d_d;
                }
            }
        }
    }
 } 
