// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MicroDonationsPool {
    address public owner;
    uint256 public totalDonations;

    // Track donations
    mapping(address => uint256) public donations;

    // Set the contract deployer as the owner
    function initializeOwner() public {
        require(owner == address(0), "Owner is already set");
        owner = msg.sender;
    }

    // Accept donations
    receive() external payable {
        donations[msg.sender] += msg.value;
        totalDonations += msg.value;
    }

    // Withdraw donations to a charity
    function withdraw(address payable charity, uint256 amount) public {
        require(msg.sender == owner, "Only owner can withdraw");
        require(amount <= address(this).balance, "Insufficient balance");
        charity.transfer(amount);
    }

    // Check contract balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

