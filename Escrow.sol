// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @title TimeLockedEscrow
 * @dev A secure vault for locking funds until a specific time.
 */
contract TimeLockedEscrow is ReentrancyGuard {
    address public immutable beneficiary;
    address public immutable depositor;
    uint256 public immutable releaseTime;

    event Released(address indexed beneficiary, uint256 amount);

    constructor(address _beneficiary, uint256 _releaseTime) {
        require(_releaseTime > block.timestamp, "Release time must be in the future");
        beneficiary = _beneficiary;
        depositor = msg.sender;
        releaseTime = _releaseTime;
    }

    /**
     * @dev Transfers locked ETH to the beneficiary.
     */
    function releaseETH() external nonReentrant {
        require(block.timestamp >= releaseTime, "Current time is before release time");
        uint256 amount = address(this).balance;
        require(amount > 0, "No ETH to release");

        (bool success, ) = beneficiary.call{value: amount}("");
        require(success, "Transfer failed");

        emit Released(beneficiary, amount);
    }

    /**
     * @dev Transfers locked ERC20 tokens to the beneficiary.
     */
    function releaseERC20(address _token) external nonReentrant {
        require(block.timestamp >= releaseTime, "Current time is before release time");
        IERC20 token = IERC20(_token);
        uint256 amount = token.balanceOf(address(this));
        require(amount > 0, "No tokens to release");

        token.transfer(beneficiary, amount);

        emit Released(beneficiary, amount);
    }

    receive() external payable {}
}
