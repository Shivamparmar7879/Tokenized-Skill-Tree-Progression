// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SkillTreeProgression {
    address public owner;
    mapping(address => uint256) public levels;
    mapping(address => uint256) public balances;

    event LevelUp(address indexed user, uint256 newLevel, uint256 reward);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function levelUp() public {
        levels[msg.sender] += 1;
        uint256 reward = calculateReward(levels[msg.sender]);
        balances[msg.sender] += reward;
        emit LevelUp(msg.sender, levels[msg.sender], reward);
    }

    function calculateReward(uint256 level) internal pure returns (uint256) {
        return level * 10;  // Reward increases with each level
    }

    function transfer(address to, uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function getLevel() public view returns (uint256) {
        return levels[msg.sender];
    }
}
