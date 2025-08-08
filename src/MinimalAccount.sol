// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {IAccount} from "account-abstraction/interfaces/IAccount.sol";
import {PackedUserOperation} from "account-abstraction/interfaces/PackedUserOperation.sol";
import Ownable from "@openzeppelin/contracts/access/Ownable.sol"; 

contract MinimalAccount is IAccount {
    uint256 public number;

    constructor() Ownable(msg.sender) {}
    
    // A signature is valid if its the Minimal Account owner

    function validateUserOp(
        PackedUserOperation calldata userOp,
        bytes32 userOpHash,
        uint256 missingAccountFunds
    ) external returns (uint256 validationData){
        _validateSignature(userOp, userOpHash);
    };

    _validateSignature
}
