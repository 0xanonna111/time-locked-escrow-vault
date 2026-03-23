# Time-Locked Escrow Vault

A professional-grade financial primitive for trustless transactions. This repository provides a secure mechanism for locking assets (ETH or ERC-20) that can only be claimed by a designated beneficiary once a time-based "lock" has expired.

## Features
* **Hard Time-Lock:** Inflexible release dates for high-assurance vesting or savings.
* **Emergency Refund:** Optional logic for the depositor to reclaim funds if the lock is not met (configurable).
* **ERC-20 Support:** Compatible with any standard utility or stablecoin.
* **Flat Structure:** Single-directory layout for rapid deployment and easy auditing.

## Logic Flow
1. **Deposit:** The `Arbiter` or `Depositor` locks funds and sets a `releaseTime`.
2. **Hold:** Funds are mathematically inaccessible until `block.timestamp >= releaseTime`.
3. **Claim:** The `Beneficiary` calls the release function to transfer funds to their wallet.

## Setup
1. `npm install`
2. Deploy `Escrow.sol` with the beneficiary address and Unix timestamp.
