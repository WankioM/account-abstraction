## Overview

This project demonstrates the core concepts of ERC-4337 Account Abstraction by:
- Creating a minimal smart contract wallet
- Deploying it on a testnet
- Sending transactions (UserOps) through the account abstraction infrastructure

## Prerequisites

- Node.js & npm
- Foundry (installed via WSL)
- MetaMask or similar wallet
- Testnet ETH (Sepolia recommended)
- Basic understanding of Solidity and smart contracts

## Project Structure

```
account-abstraction/
├── src/
│   ├── MinimalAccount.sol          # Your smart contract wallet
│   ├── AccountFactory.sol          # Factory for deploying accounts
│   └── interfaces/
├── script/
│   ├── Deploy.s.sol               # Deployment scripts
│   └── SendUserOp.s.sol          # Script to send UserOps
├── test/
│   └── MinimalAccount.t.sol       # Tests for your account
└── README.md
```

## Learning Path

### Phase 1: Understanding the Basics
1. **Study ERC-4337 Components:**
   - EntryPoint contract
   - UserOperation structure
   - Bundlers and Paymasters
   - Account factories

2. **Analyze MinimalAccount.sol:**
   - Understand the current simple contract
   - Learn what makes it AA-compatible
   - Study validation functions needed

### Phase 2: Building the Account
1. **Implement IAccount interface:**
   - `validateUserOp()` function
   - Signature validation logic
   - Nonce management

2. **Add Factory Pattern:**
   - Create account deployment factory
   - Implement CREATE2 for deterministic addresses
   - Handle initialization

### Phase 3: Testing & Deployment
1. **Write Comprehensive Tests:**
   - Unit tests for account logic
   - Integration tests with EntryPoint
   - Gas usage analysis

2. **Deploy to Testnet:**
   - Deploy account factory
   - Deploy your first account instance
   - Verify contracts on Etherscan

### Phase 4: Sending UserOperations
1. **Prepare UserOperation:**
   - Structure the UserOp object
   - Calculate gas limits
   - Generate proper signatures

2. **Submit via Bundler:**
   - Find a compatible bundler service
   - Submit UserOp to mempool
   - Monitor transaction execution

## Key Concepts to Learn

### UserOperation Structure
```solidity
struct UserOperation {
    address sender;           // Your account address
    uint256 nonce;           // Anti-replay nonce
    bytes initCode;          // Account deployment code (if needed)
    bytes callData;          // Function call data
    uint256 callGasLimit;    // Gas for the call
    uint256 verificationGasLimit; // Gas for validation
    uint256 preVerificationGas;   // Gas overhead
    uint256 maxFeePerGas;         // Max gas price
    uint256 maxPriorityFeePerGas; // Priority fee
    bytes paymasterAndData;       // Paymaster info (optional)
    bytes signature;              // Account signature
}
```

### Account Interface Requirements
```solidity
interface IAccount {
    function validateUserOp(
        UserOperation calldata userOp,
        bytes32 userOpHash,
        uint256 missingAccountFunds
    ) external returns (uint256 validationData);
}
```

## Development Milestones

- [ ] **Milestone 1:** Understand ERC-4337 architecture
- [ ] **Milestone 2:** Implement basic account validation
- [ ] **Milestone 3:** Create account factory
- [ ] **Milestone 4:** Write comprehensive tests
- [ ] **Milestone 5:** Deploy to Sepolia testnet
- [ ] **Milestone 6:** Send first UserOperation
- [ ] **Milestone 7:** Add paymaster integration (advanced)

## Useful Resources

### Official Documentation
- [ERC-4337 Specification](https://eips.ethereum.org/EIPS/eip-4337)
- [Account Abstraction Official Docs](https://docs.alchemy.com/docs/account-abstraction-overview)

### Development Tools
- **EntryPoint Address (Sepolia):** `0x5FF137D4b0FDCD49DcA30c7CF57E578a026d2789`
- **Bundler Services:** Alchemy, Biconomy, Stackup
- **Testing Framework:** Foundry forge

### Learning Resources
- [AA Workshop by Ethereum Foundation](https://github.com/eth-infinitism/account-abstraction)
- [OpenZeppelin AA Contracts](https://github.com/OpenZeppelin/openzeppelin-contracts/tree/master/contracts/account)

## Next Steps

1. Start by studying the ERC-4337 specification
2. Examine existing AA wallet implementations
3. Implement `validateUserOp` in your MinimalAccount
4. Build comprehensive tests
5. Deploy and test on Sepolia

## Tips for Success

- **Start Simple:** Focus on basic validation before adding advanced features
- **Test Thoroughly:** AA involves complex gas calculations and signature validation
- **Use Debugger:** Foundry's debugging tools are invaluable for AA development
- **Monitor Gas:** UserOps have multiple gas limits to consider
- **Study Examples:** Look at successful AA implementations for patterns

---
