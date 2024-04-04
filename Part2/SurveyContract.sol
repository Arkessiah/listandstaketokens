// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SurveyContract {

    address public storageContract;
    
    mapping(address => mapping(uint256 => bool)) public hasVoted; // User => Survey ID => Voted for

    struct Survey {
        address token;
        string question;
        mapping(uint256 => uint256) votes; // Option => Vote count
        uint256 totalVotes;
        bool active;
    }

    mapping(uint256 => Survey) public surveys;
    uint256 public surveyCount;

    event SurveyCreated(uint256 indexed id, address indexed token, string question);
    event Voted(uint256 indexed id, address indexed user, uint256 option);

    constructor(address _storageContract) {
        storageContract = _storageContract;
        surveyCount = 0;
    }

    function createSurvey(address token, string memory question) external {
        require(token != address(0), "Invalid token address");

        surveyCount++;
        surveys[surveyCount].token = token;
        surveys[surveyCount].question = question;
        surveys[surveyCount].active = true;

        emit SurveyCreated(surveyCount, token, question);
    }

    function vote(uint256 id, uint256 option) external {
        require(surveys[id].active, "Survey not active");
        require(option > 0, "Option must be greater than 0");
        require(!hasVoted[msg.sender][id], "Already voted");

        // Validates that the user has the necessary token to vote.
        require(IERC20(surveys[id].token).balanceOf(msg.sender) > 0, "Insufficient token balance");

        surveys[id].votes[option]++;
        surveys[id].totalVotes++;
        hasVoted[msg.sender][id] = true;
        emit Voted(id, msg.sender, option);
    }
}