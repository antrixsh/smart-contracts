pragma solidity ^0.4.0;
contract StateTransV2 {
    enum Stage {Init, Reg, Vote, Done}
    Stage public stage;
    uint startTime;
    uint public timeNow;
    
    function StateTransV2() public {
        stage = Stage.Init;
        startTime = now;
        
    }
    //Assuming the stage change has to be enacted Approx every 1 minute
    //timeNow variable is defined for understanding the process, you can simple use 
    //'now' solidity defined variable
    //ofcourse, time duration for the stages may depend on your application
    //1 minute is set to illustrate the working
    function advanceState () public {
        timeNow = now;
        if (timeNow > (startTime+ 10 seconds)) {
            startTime = timeNow;
            if (stage == Stage.Init) {stage = Stage.Reg; return;}
            if (stage == Stage.Reg) {stage = Stage.Vote; return;}
            if (stage == Stage.Vote) {stage = Stage.Done; return;}
        }
    }
}