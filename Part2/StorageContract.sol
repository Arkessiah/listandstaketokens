// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StorageContract {
    address private owner;
    address public stakingContract;
    address public surveyContract;

    event StakingContractUpdated(address indexed newAddress);
    event SurveyContractUpdated(address indexed newAddress);
 

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function updateStakingContract(address _newAddress) external onlyOwner {
        stakingContract = _newAddress;
        emit StakingContractUpdated(_newAddress);
    }

    function updateSurveyContract(address _newAddress) external onlyOwner {
        surveyContract = _newAddress;
        emit SurveyContractUpdated(_newAddress);
    }
}