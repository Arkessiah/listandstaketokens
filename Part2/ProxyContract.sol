
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./StorageContract.sol";

contract ProxyContract {
    address public storageContract;

    constructor(address _storageContract) {
        storageContract = _storageContract;
    }

    fallback() external {
        address logicContract = StorageContract(storageContract).stakingContract();
        require(logicContract != address(0), "Invalid logic contract address");
        (bool success, ) = logicContract.delegatecall(msg.data);
        require(success, "Delegatecall failed");
    }
}