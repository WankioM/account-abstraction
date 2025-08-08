// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {IAccount} from "account-abstraction/interfaces/IAccount.sol";
import {PackedUserOperation} from "account-abstraction/interfaces/PackedUserOperation.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol"; 
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol"; 
import {MessageHashUtils} from "@openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol";
import {SIG_VALIDATION_FAILED, SIG_VALIDATION_SUCCESS} from "account-abstraction/core/Helpers.sol";
import {IEntryPoint} from "account-abstraction/interfaces/IEntryPoint.sol";

contract MinimalAccount is IAccount, Ownable  {
   error MinimalAccount_NotFromEntryPoint();

    uint256 ourNonce =0;
    IEntryPoint private immutable i_entryPoint;

    constructor( address entryPoint) Ownable(msg.sender) {
        i_entryPoint =IEntryPoint (entryPoint);
    }

    modifier requireFromEntryPoint() {
        if (msg.sender != address(i_entryPoint)) {
            revert MinimalAccount_NotFromEntryPoint();
        }
        _;  
    }
    
    // A signature is valid if its the Minimal Account owner

    function validateUserOp(
        PackedUserOperation calldata userOp,
        bytes32 userOpHash,
        uint256 missingAccountFunds
    ) external
    requireFromEntryPoint 
    returns (uint256 validationData){
         validationData= _validateSignature(userOp, userOpHash);
        // Validate Nonce
        _payPrefund(missingAccountFunds);
    }

    function _validateSignature (PackedUserOperation calldata userOp, bytes32 userOpHash) 
    internal
    view
    returns (uint256 validationData)

    {
        bytes32 ethSignedMessageHash = MessageHashUtils.toEthSignedMessageHash(userOpHash);
        address signer = ECDSA.recover(ethSignedMessageHash, userOp.signature);

        if (signer != owner ()){
            return SIG_VALIDATION_FAILED;
        }
        return SIG_VALIDATION_SUCCESS;
    }

    function _payPrefund(uint256 missingAccountFunds) internal {
        if (missingAccountFunds != 0) {
            (bool success,) = payable(msg.sender).call{  // Fixed call syntax
                value: missingAccountFunds
            }("");
            require(success, "Failed to pay prefund");
        }
    }


    ///GETTTERS

    function getEntryPoint()  external view returns (address) {
        return address(i_entryPoint);
    }
}
