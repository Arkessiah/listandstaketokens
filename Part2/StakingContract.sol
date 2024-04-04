// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract StakingContract {

    address public storageContract;

    mapping(address => uint256) public stakedBalance;
    mapping(address => uint256) public stakingTokens;

    address public tokenAddress;

    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    constructor(address _storageContract, address _tokenAddress) {
        storageContract = _storageContract;
        tokenAddress = _tokenAddress;
    }

    function stake(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(
            IERC20(tokenAddress).transferFrom(msg.sender, address(this), amount),
            "Transfer failed"
        );

        stakedBalance[msg.sender] += amount;
        stakingTokens[msg.sender] += amount;
        emit Staked(msg.sender, amount);
    }

    function withdraw(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(amount <= stakedBalance[msg.sender], "Insufficient balance");

        stakedBalance[msg.sender] -= amount;
        stakingTokens[msg.sender] -= amount;
        require(
            IERC20(tokenAddress).transfer(msg.sender, amount),
            "Transfer failed"
        );
        emit Withdrawn(msg.sender, amount);
    }
}