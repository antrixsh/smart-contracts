pragma solidity ^0.4.0;

contract Ballot {
    
    struct Voter {
        uint weight;
        bool voted;
        uint8 vote;
        //address delegate;
    }
    struct Proposal {
        uint voteCount; //could add other data about Proposal
    }
    
    address chairperson;
    mapping(address => Voter) voters;
    Proposal[] proposals;
    
    
    ///create a ballot with $(_numProposals) different proposals.
    function Ballot(uint8 _numProposals) public {
        chairperson = msg.sender;
        voters[chairperson].weight = 2;
        proposals.length = _numProposals;
    }
    ///Give $(toVoter) the right to vote on this ballot;
    ///may only be called by $(chairperson).
    function register(address toVoter) public {
        if (msg.sender != chairperson || voters[toVoter].voted) return;
        voters[toVoter].weight =1;
        voters[toVoter].voted = false;
    }
    ///Give a Single vote to Proposal $(toProposals)
    function vote(uint8 toProposals) public {
        Voter storage sender = voters[msg.sender];
        if (sender.voted || toProposals >= proposals.length) return;
        sender.voted = true;
        sender.vote = toProposals;
        proposals[toProposals].voteCount += sender.weight;
    }
    
    function winningProposal() public constant returns (uint8 _winningProposal){
        uint256 winningVoteCount = 0;
        for (uint8 prop = 0; prop < proposals.length; prop++) {
            if (proposals[prop].voteCount > winningVoteCount){
                winningVoteCount = proposals[prop].voteCount;
                _winningProposal = prop;
            }
        }
        
    }
}